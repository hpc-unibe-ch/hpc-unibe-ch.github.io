[data-storage-options]: ../storage/index.md
[ubelix-ondemand]: https://ondemand.hpc.unibe.ch

# Moving data to/from UBELIX

For moving data to/from UBELIX, we recommend the use of the `scp` and `rsync`
tools. See the [data storage options][data-storage-options] page for an
overview of where to store your data on UBELIX.

In situations where you need to simply download data from the web, you can use
tools like `wget` and `curl`.

## Copying files with `scp`

Copying files between different UNIX-like systems can be done with the `scp`
command. This command, which stands for *Secure Copy Protocol*, allows you to
transfer files between a local host and a remote host or between two remote
hosts. The basic syntax of the `scp` command is the following:

```bash
scp <origin-path> [user@]host:<destination-path>
scp [user@]host:<origin-path> <destination-path>
```

where `<origin-path>` is the path to the file you want to copy to the 
destination defined by `<destination-path>`.

Some common `scp` options:

```bash
-r copy directories recursively (Note that SCP follows symbolic links encountered in the tree traversal)
-p preserve modification time, access time, and modes from the original file
-v verbose mode
```

### Copying Files to UBELIX

Copy the file `~/dir/file01` to your remote home directory:

```Bash
$ scp ~/dir/file01 <user>@submit03.unibe.ch:
```

Copy multiple files to the remote directory `~/bar`:

!!! note

    The destination directory must already exist. You can create a directory from remote with: `ssh <user>@submit03.unibe.ch 'mkdir -p ~/bar'`

```Bash
$ scp ~/dir/file01 ~/dir/file02 ~/dir/file03 <user>@submit03.unibe.ch:bar
```

Copy the directory `~/dir` to the remote directory `~/bar` using
the `-r` (recursive) option:

```Bash
$ scp -r ~/dir <user>@submit03.unibe.ch:~/bar/
```

### Copying Files from UBELIX

Copy the remote file `~/bar/file01` to the current working directory on your local workstation:

```Bash
$ scp <user>@submit03.unibe.ch:bar/file01 .
```

Copy multiple remote files to the local directory `~/dir`:

```Bash
$ scp <user>@submit03.unibe.ch:bar/\{file02,file03,file04\} ~/dir
```

The local directory `~/dir` will be automatically created if it does not already exist

Copy the remote directory `~/bar` to the current working directory on your local workstation:

```Bash
$ scp -r <user>@submit03.unibe.ch:bar .
```

## Copying files with `rsync`

The `rsync` tool, which stands for *Remote Sync*, is a remote and local file
synchronization tool. It has the advantage of minimizing the amount of data
copied by only copying files that have changed. The advantages over `scp` are

- It allows for synchronization. `scp` always copies and transfers everything,
  while `rsync` will only copy and transfer files that have changed.
- Better for the transfer of large files as `rsync` can save progress.
  If the transfer is interrupted it can be resumed from the point of interruption.

The basic syntax of the `rsync` command is the following:

```bash
rsync <options> <origin-path> <destination-path>
rsync <options> <origin-path> [user@]host:<destination-path>
rsync <options> [user@]host:<origin-path> <destination-path>
```

Common options:

```bash
-r copy directories recursively (does not preserve timestamps and permissions)
-a archive mode (like -r, but also preserves timestamps, permissions, ownership, and copies symlinks as symlinks)
-z compress data
-v verbose mode (additional v's will increase verbosity level)
-n dry-run
-h output numbers in a human readable format
```

To copy the contents of remote directory `~/foo/` to the local directory `~/dir`:

```Bash
$ rsync -az <user>@submit03.unibe.ch:foo/ ~/dir
```

!!! note 
    With a trailing slash (`/`) after the source directory only the content of the source directory is copied to the destination directory. Without a trailing slash both the source directory and the content of the directory are copied to the destination directory.


## Copying files with OnDemand

You can also use the interactive [UBELIX OnDemand portal][ubelix-ondemand] to upload or download (small) files from/to UBELIX.
Access the Files App from the top menu bar under `Files > Home Directory`. 
