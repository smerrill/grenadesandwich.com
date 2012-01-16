---
layout: post
title: "Setting Up Your L(ion)AMP Stack"
created: 1306726837
categories:
- os x lion
- web development
- drupal
---

1. Install XCode (or just gcc)
2. Install Homebrew
3. Brew up some software
4. Make the LAMP brighter

<!-- break -->

## Install XCode (or just gcc)

## Install Homebrew

## Brew up some software

## Make the LAMP brighter

### Get MySQL configured

Edit /etc/my.cnf and put the following in:

```[mysql]
# Packets.
max_allowed_packet=16m

[mysqld]
# Packets.
max_allowed_packet=16m

# Wait timeouts.
innodb_lock_wait_timeout=600
wait_timeout=600
connect_timeout=10

# Set this as high as possible. On a dedicated server, 60% - 80% of machine RAM.
innodb_buffer_pool_size=512m

# Set this to the number of logical cores you have on the database server.
innodb_thread_concurrency=4

# Turn this on dynamically with a Jenkins job.
slow_query_log=OFF

# Max number of connections allowed.
max_connections=400

# Don't run out of file descriptors!
open_files_limit=32768

# If you set the query cache too high, your server risks severly slowing down and taking tens of seconds after an INSERT due to query cache mutex contention.
query_cache_limit=1M
query_cache_size=32M

# This allows a long-running query to not hit the network for a while and yet not be killed by MySQL.
net_read_timeout=3600
net_write_timeout=3600

# This only works with Percona but allows you to pare down which slow queries go to the log.
#log_slow_filter=tmp_table_on_disk,filesort_on_disk

# Use InnoDB as the default engine.
# default_storage_engine = InnoDB
# default_character_set = utf8
# collation_server = utf8_general_ci
# character_set_server = utf8

# Smaller InnoDB files mean less disk I/O when a new one is created.
innodb_log_file_size=512m
innodb_log_buffer_size=64m
innodb_file_per_table

# Speed up write performance significantly. You risk losing at most 1 or 2 seconds of data in event of a power loss or other catastrophic failure.
innodb_flush_log_at_trx_commit=0

# Max temp table size in RAM - larger can be set in application with a per-session SET.
max_heap_table_size=64m
tmp_table_size=64m

# Per-session mem settings for sorts, joins, order by etc
join_buffer_size=2m
sort_buffer_size=2m
read_rnd_buffer_size=2m
read_buffer_size=2m

# Block size inside query cache - reduce pruning
query_cache_min_res_unit=1024```

