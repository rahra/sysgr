# sysgr

This is simple tool which should work out of the box to create system state diagrams such as CPU load, disk usage, network stats, and so on. It sources further simple scripts (found in rrdscripts) which actually collect the data of the system.

# How to use

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

