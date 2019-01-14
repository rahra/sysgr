# sysgr

This is a simple tool which should work out of the box to create system state diagrams such as CPU load, disk usage, network stats, and so on. It sources further simple scripts (found in `rrdscripts/`) which actually collect the data of the system.
Furthermore it is very easy to add own data collectors without fiddling with `rrdtool`.

# How To Use

It depends on rrdtool, thus install the package `rrdtool` first (e.g. with apt-get).

Download everything from this directory, i.e. `sysgr` and the `rrdscripts` directory.

```Shell
git clone https://github.com/rahra/sysgr
```

Change into the directory and run `./sysgr`. It will create the directory var where all charts are place.

It is suggested to be run from `cron`.
Thus, 1st create a config file `.sysgr.conf` in `$HOME` and add the following two lines and modify appropriately:

```Shell
RRDHOME=/var/www/apache24/stats/rrd
RRDSCRIPTS=<path_to_your>/rrdscripts
```

Now edit your `crontab` with `crontab -e` and add the following line:

```Cron
*/5 * * * * <path_to_your_git_clone>/sysgr
```

# Adding Own Collectors

As an example we'd like to monitor the total number of running processes.

Create a shell script in `rrdscripts/`. The file shall have the extension `.sh`.
In this case the file is named `rrdscripts/nprocs.sh`

The file basically shall export at least the variable `RRDDATA` containing the data in the following format:
```Shell
RRDDATA=var1name:var1data [var2name:var2data [ ... ] ]
```

Our example shell script counts the total number of processes:
```Shell
RRDDATA=nprocs:$(ps uax | wc -l | tr -d \  )
```

`ps uax` lists all processes one on each line, `wc -l` counts the number of lines and outputs the value, `tr -d \ ` eliminates whitespaces in the string.

