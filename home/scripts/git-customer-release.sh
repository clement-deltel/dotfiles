#!/bin/bash
set -e

# Configuration
USAGE="Usage: $0 --action={init|update|push} [--vendor-url=<repository_url>] [--customer-url=<repository_url>] [--exclude=file1,file2,dir/] [--pull-branch=<branch_name>] [--push-branch=<branch_name>] [--customer-remote=<remote_name>] [--work-dir=<dir_name>] [--force]"

# Parse named arguments
while [ $# -gt 0 ]; do
    case "$1" in
	    --action=*)
        ACTION="${1#*=}"
        shift
        ;;
        --vendor-url=*)
        VENDOR_URL="${1#*=}"
        shift
        ;;
        --customer-url=*)
        CUSTOMER_URL="${1#*=}"
        shift
        ;;
        --exclude=*)
        IFS=',' read -r -a EXCLUDED_FILES <<< "${1#*=}"
        shift
        ;;
		--pull-branch=*)
        VENDOR_PULL_BRANCH="${1#*=}"
        shift
        ;;
		--push-branch=*)
        CUSTOMER_PUSH_BRANCH="${1#*=}"
        shift
        ;;
        --customer-remote=*)
        CUSTOMER_REMOTE="${1#*=}"
        shift
        ;;
		--work-dir=*)
        WORK_DIR="${1#*=}"
        shift
        ;;
        *)
        echo "Unknown parameter: $1"
        echo "$USAGE"
        exit 1
        ;;
    esac
done

# Validate required parameters
if [ -z "$ACTION" ]; then
    echo "Missing required parameters"
    echo "$USAGE"
    exit 1
fi

# Set default parameters if not specified
VENDOR_PULL_BRANCH="${VENDOR_PULL_BRANCH:-main}"
CUSTOMER_PUSH_BRANCH="${CUSTOMER_PUSH_BRANCH:-main}"
CUSTOMER_REMOTE="${CUSTOMER_REMOTE:-customer}"
WORK_DIR="${WORK_DIR:.}"

# Function to filter out internal files
filter_internal_files() {
    # Create filter spec file
    local filter_file="filter-spec.txt"
    printf "%s\n" "${EXCLUDED_FILES[@]}" > "$filter_file"

    # Use git filter-repo for more reliable filtering
    git filter-repo \
        --invert-paths \
        --paths-from-file "$filter_file" \
        --force

    rm -f filter-spec.txt
}

# Command router
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

case "$ACTION" in
    "init")
	    # Clone repository
        git clone -b "$VENDOR_PULL_BRANCH" --single-branch "$VENDOR_URL" .
		# Filter out internal files
        filter_internal_files
        # Create vendor and customer remotes
        git remote -v | grep -w origin || git remote add origin "$VENDOR_URL"
        git remote -v | grep -w "$CUSTOMER_REMOTE" || git remote add "$CUSTOMER_REMOTE" "$CUSTOMER_URL"
        ;;

    "update")
        git checkout "$VENDOR_PULL_BRANCH"
        git pull origin "$VENDOR_PULL_BRANCH" --no-rebase --no-commit
        # Filter out internal files
        filter_internal_files
        ;;

    "push")
		# Disable LFS prior pushing
		git lfs uninstall
        if [ "$FORCE_PUSH" = true ]; then
            git push "$VENDOR_PULL_BRANCH" "$CUSTOMER_REMOTE:$CUSTOMER_PUSH_BRANCH" --force
        else
            git push "$VENDOR_PULL_BRANCH" "$CUSTOMER_REMOTE:$CUSTOMER_PUSH_BRANCH"
        fi
		# Re-enable LFS
		git lfs install --skip-smudge
        ;;

    *)
        echo "Invalid action. Use: init, update, or push"
		echo "$USAGE"
        exit 1
        ;;
esac
