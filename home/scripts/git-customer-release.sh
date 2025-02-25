#!/bin/bash

#==============================================================================#
#AUTHOR: Clement Deltel
#DATE: 2025/02/06
#DESCRIPTION: push code to customer's environment without internal only files.
#PARAMETERS:
#  action:
#    init: initialize the repository with internal files being removed.
#    update: pull changes from the vendor's version control system when needed.
#    push: push the changes to the customer's version control server, whether it is the first push or after an update.
#  vendor-url: url used to create the remote pointing towards the vendor's environment.
#  customer-url: url used to create the remote pointing towards the customer's environment.
#  exclude-files: list of files to remove from the repository.
#  pull-branch: remote branch to pull from the vendor's version control system. Defaults to main.
#  push-branch: remote branch to push to on the customer's version control system. Defaults to main.
#  customer-remote: name of the customer's remote in the local repository. Defaults to customer.
#  update-message: commit message to merge updates. Defaults to "chore: add latest updates from origin".
#  work-dir: directory where to run the script. Defaults to current directory.
#  force: flag used to force a git push.
#==============================================================================#

set -e

# Configuration
USAGE="Usage: $0 --action={init|update|push} [--vendor-url=<repository_url>] [--customer-url=<repository_url>] [--exclude=file1,file2,dir/] [--pull-branch=<branch_name>] [--push-branch=<branch_name>] [--customer-remote=<remote_name>] [--update-message=<commit_message>] [--work-dir=<dir_name>] [--force]"

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
        --update-message=*)
        UPDATE_MESSAGE="${1#*=}"
        shift
        ;;
		--work-dir=*)
        WORK_DIR="${1#*=}"
        shift
        ;;
        --force)
        FORCE_PUSH="true"
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
UPDATE_MESSAGE="${UPDATE_MESSAGE:-chore: add latest updates from origin}"
WORK_DIR="${WORK_DIR:-.}"

# Function to filter out internal files
filter_internal_files() {
    # Create filter spec file
    local filter_file="filter-spec.txt"
    echo "$EXCLUDED_FILES" | tr ',' '\n' > "$filter_file"

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
        git commit -m "$UPDATE_MESSAGE"
        # Filter out internal files
        filter_internal_files
        ;;

    "push")
		# Disable LFS prior pushing
		git lfs uninstall
        if [[ "$FORCE_PUSH" == "true" ]]; then
            git push "$CUSTOMER_REMOTE" "$VENDOR_PULL_BRANCH:$CUSTOMER_PUSH_BRANCH" --force
        else
            git push "$CUSTOMER_REMOTE" "$VENDOR_PULL_BRANCH:$CUSTOMER_PUSH_BRANCH"
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
