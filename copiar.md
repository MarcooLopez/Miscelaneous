The very basic usage:
```
scp remote_user@hpcc.msu.edu:/path/to/remote/file /path/to/local/file
```
and vice versa:
```
scp /path/to/local/file remote_user@hpcc.msu.edu:/path/to/remote/file
```
To copy files that only meet certain criteria (provided by \*), using rsync is recommended
```
rsync -av --include='*/' --include 'M2b_P*_P*_ETA_W2_b.bin' --exclude='*' remote_user@hpcc.msu.edu:/path/to/remote/folder /path/to/local/folder
```
