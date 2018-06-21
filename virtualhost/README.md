# 添加主机角色

```
docker node update --label-add virtualhost.mysql=true Docker01
docker node update --label-add virtualhost.ftp=true Docker01
```

# 部署服务

```
docker stack deploy -c docker-compose.yml virtualhost
```

# 创建数据库

```
use ftp;
CREATE TABLE ftp_group (
  groupname varchar(16) NOT NULL default '',
  gid smallint(6) NOT NULL default '82',
  members varchar(16) NOT NULL default '',
  KEY groupname (groupname)
) ENGINE=MyISAM COMMENT='ProFTP group table';
CREATE TABLE ftp_user (
  id int(10) unsigned NOT NULL auto_increment,
  userid varchar(32) NOT NULL default '',
  passwd varchar(32) NOT NULL default '',
  uid smallint(6) NOT NULL default '82',
  gid smallint(6) NOT NULL default '82',
  homedir varchar(255) NOT NULL default '',
  shell varchar(16) NOT NULL default '/sbin/nologin',
  count int(11) NOT NULL default '0',
  accessed datetime NOT NULL DEFAULT '2018-03-02 13:45:45',
  modified datetime NOT NULL DEFAULT '2018-03-02 13:45:45',
  PRIMARY KEY (id),
  UNIQUE KEY userid (userid)
) ENGINE=MyISAM COMMENT='ProFTP user table';
CREATE INDEX groups_gid_idx ON ftp_group (gid);
```

# 创建FTP管理员
```
INSERT INTO `ftp_group` (`groupname`, `gid`, `members`) VALUES ('www-data', 82, 'ftpuser')
INSERT INTO `ftp_user` (`userid`, `passwd`, `uid`, `gid`, `homedir`, `shell`, `count`, `accessed`, `modified`) VALUES ('ftpuser', ENCRYPT('ftppassword'), 82, 82, '/var/www', '/sbin/nologin', 0, '2018-03-02 13:45:45', '2018-03-02 13:45:45')
```

# 设置FTP目录权限

```
chown -R 82:82 /var/www
chmod 755 /var/www
```