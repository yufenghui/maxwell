## Maxwell

<div id="maxwell-header">
</div>

This is Maxwell's daemon, an application that reads MySQL binlogs and writes
row updates as JSON to Kafka, Kinesis, or other streaming platforms.  Maxwell has
low operational overhead, requiring nothing but mysql and a place to write to.
Its common use cases include ETL, cache building/expiring, metrics collection,
search indexing and inter-service communication.  Maxwell gives you some of the
benefits of event sourcing without having to re-architect your entire platform.

### 数据库配置

- my.cnf
```shell script
[mysqld]
server_id=1
log-bin=master
binlog_format=row
```
- 用户
```shell script
CREATE USER 'maxwell'@'%' IDENTIFIED BY 'maxwell';
GRANT ALL ON maxwell.* TO 'maxwell'@'%';
GRANT SELECT, REPLICATION CLIENT, REPLICATION SLAVE ON *.* TO 'maxwell'@'%';
```

### 修改说明

- 增加日期时区内置处理，包含timestamp 和 datetime 类型
- 修改Dockerfile部分内容
- 新增功能提交到 `1.27.0_feature_date-timezone` 分支，方便未来与上游版本合并

#### Download
[https://github.com/zendesk/maxwell/releases/download/v1.27.0/maxwell-1.27.0.tar.gz](https://github.com/zendesk/maxwell/releases/download/v1.27.0/maxwell-1.27.0.tar.gz)


#### Source
[https://github.com/zendesk/maxwell](https://github.com/zendesk/maxwell)
<br clear="all">


```
  mysql> insert into `test`.`maxwell` set id = 1, daemon = 'Stanislaw Lem';
  maxwell: {
    "database": "test",
    "table": "maxwell",
    "type": "insert",
    "ts": 1449786310,
    "xid": 940752,
    "commit": true,
    "data": { "id":1, "daemon": "Stanislaw Lem" }
  }
```

```
  mysql> update test.maxwell set daemon = 'firebus!  firebus!' where id = 1;
  maxwell: {
    "database": "test",
    "table": "maxwell",
    "type": "update",
    "ts": 1449786341,
    "xid": 940786,
    "commit": true,
    "data": {"id":1, "daemon": "Firebus!  Firebus!"},
    "old":  {"daemon": "Stanislaw Lem"}
  }
```
