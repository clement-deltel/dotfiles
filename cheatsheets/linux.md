# Linux cheatsheet <!-- omit in toc -->

## Table of Contents <!-- omit in toc -->

- [1. Groups and users](#1-groups-and-users)
  - [groupadd](#groupadd)
  - [id](#id)
  - [useradd](#useradd)
  - [usermod](#usermod)
  - [who](#who)
  - [Other](#other)
- [2. Directories and files](#2-directories-and-files)
  - [find](#find)
  - [grep](#grep)
  - [head](#head)
  - [sed](#sed)
    - [Delete](#delete)
  - [tail](#tail)
- [3. Permissions](#3-permissions)
  - [chmod](#chmod)
  - [chown](#chown)
- [4. Compression](#4-compression)
  - [gzip](#gzip)
  - [tar](#tar)
- [5. Processes](#5-processes)
- [6. Network](#6-network)
- [7. Data from internet](#7-data-from-internet)
  - [curl](#curl)
- [8. Other](#8-other)
  - [Add user to the sudoers file](#add-user-to-the-sudoers-file)
  - [Change user and group for all owned files](#change-user-and-group-for-all-owned-files)
  - [Create a file of a certain size](#create-a-file-of-a-certain-size)
  - [du](#du)


## 1. Groups and users

### groupadd

Create a new group
```bash
groupadd -g <gid> <groupname>
```

### id

Print real and effective user and group IDs
```bash
id
```

### useradd

Create a new user or update default new user information
```bash
useradd -c "<comment>" -m -d <home> -s <shell> -g <groupname> -u <uid> <username>
```

### usermod

- Add user to the sudoers group
```bash
usermod -aG sudo <username>
```

### who

Show who is logged on
```bash
who
```

### Other

- List groups
```bash
cat /etc/group
```

- List users
```bash
cat /etc/passwd
```

## 2. Directories and files

### find

Search for files in a directory hierarchy

- Group filter
```bash
find <directory> -group <groupname>
```

- User filter
```bash
find <directory> -user <username>
```

- One user or the other
```bash
find <directory> -user <username1> -o -user <username2>
```

- Filename filter
```bash
find <directory> -name "*.txt"
```

- Case insensitive
```bash
find <directory> -iname "*.txt"
```

- Directory type filter
```bash
find <directory> -type d
```

- File type filter
```bash
find <directory> -type f
```

### grep

...

### head

Output the first part of files

- Default
```bash
head <input-file>
```

- Limit number of lines
```bash
head -n <number> <input-file>
```

### sed

Stream editor for filtering and transforming text

#### Delete

- Delete empty lines from file
```bash
sed '/^$/d' <input-file>
```

- Delete lines matching pattern from file
```bash
sed '/<pattern>/d' <input-file>
```

### tail

Output the last part of files

- Default
```bash
tail <input-file>
```

- Limit number of lines
```bash
tail -n <number> <input-file>
```

- Streaming output of a changing file
```bash
tail -f <input-file>
```

## 3. Permissions

### chmod

Change file mode bits

- Add execute permission
```bash
chmod +x <input-file>
```

- Change permissions
```bash
chmod 777 <input-file>
```

- Recursive
```bash
chmod 777 -R <input-directory>
```

### chown

Change file owner and group

- Default
```bash
chown <groupname>:<username> <input-file>
```

- Recursive
```bash
chown <groupname>:<username> -R <input-directory>
```

## 4. Compression

### gzip

Compress or expand files
- Compress
```bash
gzip -v <input-file>
```

- Compress multiple files
```bash
gzip -v <input-file1> <input-file2>
```

- Compress directory
```bash
gzip -rv <input-directory>
```

- Change the compression level (between 1 and 9, default being 6)
```bash
gzip -9 -v <input-file>
```

- Expand
```bash
gzip -dv <input-file>
```

- List gzip file's content
```bash
gzip -l <input-file>
```

### tar

Saves many files together into a single tape or disk archive, and can restore individual files from the archive
- Compress
```bash
tar -cvf <archive> <input-file>
```

- Compress with gzip option
```bash
tar -cvzf <archive> <input-file>
```

- Expand
```bash
tar -xvf <archive>
```

- Expand with gzip option
```bash
tar -xvzf <archive>
```

- Expand in a different directory than the current
```bash
tar -xvf <archive> -C <directory>
```

- List tar file's content
```bash
tar -tvf <archive>
```

## 5. Processes

...

## 6. Network

...

## 7. Data from internet

### curl

Transfer a URL, supported protocols are: HTTP, HTTPS, FTP, FTPS, SCP, SFTP, TFTP, DICT, TELNET, LDAP, FILE

- Download a file with its name as is
```bash
curl -O https://<domain>/<input-file>
```

- Set output file name
```bash
curl -o <output-file> https://<domain>/l<input-file>
```

## 8. Other

### Add user to the sudoers file

- Grant permissions to run all commands without password prompt
```bash
echo "{username}  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers
```

### Change user and group for all owned files

- Change group id
```bash
groupmod -u <new-gid> <groupname>
```

- Change user id
```bash
usermod -u <new-uid> <username>
```

- Change group for all owned directories and files in the system
```bash
find / -group <old-gid> -exec chgrp -h <groupname> {} \;
```

- Change user for all owned directories and files in the system
```bash
find / -user <old-uid> -exec chown -h <groupname> {} \;
```

### Create a file of a certain size

- truncate
```bash
truncate -s 5M <output-file>
```

- fallocate
```bash
fallocate -l 5242880 <output-file>
```
- head - Random
```bash
head -c 5MB /dev/urandom > <output-file>
```

- head - Zeros
```bash
head -c 5MB /dev/zero > <output-file>
```

### du

Estimate file space usage

- Default
```bash
sudo du -sh <directory>
```

- First-level subdirectories
```bash
sudo du -h --max-depth=1 <directory>
```
