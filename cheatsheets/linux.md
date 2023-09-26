# Linux cheatsheet <!-- omit in toc -->

## Table of Contents <!-- omit in toc -->

- [du](#du)
- [find](#find)
- [sed](#sed)
  - [Delete](#delete)
- [Other](#other)


## du

- Get the size of a directory

```bash
sudo du -sh <directory>

# First-level subdirectories
sudo du -h --max-depth=1 <directory>
```

## find

```bash
# Group
find <directory> -group <groupname>

# User
find <directory> -user <username>

# One user or the other
find <directory> -user <username1> -o -user <username2>


# Filename constraint
find <directory> -name "*.txt"

# Case insensitive
find <directory> -iname "*.txt"


# Directories only
find <directory> -type d

# Files only
find <directory> -type f
```

## sed

### Delete

- Delete empty lines from file

```bash
sed '/^$/d' <input-file>
```

- Delete lines matching pattern from file

```bash
sed '/<pattern>/d' <input-file>
```

## Other

- Create a file of a certain size

```bash
truncate -s 5M <output-file>
fallocate -l 5242880 <output-file>

# Random
head -c 5MB /dev/urandom > <output-file>
# Zeros
head -c 5MB /dev/zero > <output-file>
```
