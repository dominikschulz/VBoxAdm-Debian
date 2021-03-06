## mysqldiff 0.43
## 
## Run on Mon Jan 30 20:52:12 2012
## Options: debug=0
##
## --- file: /tmp/vboxadm-upgrades/schema-0.0.23.sql
## +++ file: /tmp/vboxadm-upgrades/schema-0.0.24.sql

ALTER TABLE aliases ADD COLUMN CONSTRAINT aliases_ibfk_1 FOREIGN KEY (domain_id) REFERENCES domains (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE domain_aliases ADD COLUMN CONSTRAINT domain_aliases_ibfk_1 FOREIGN KEY (domain_id) REFERENCES domains (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE mailboxes ADD COLUMN CONSTRAINT mailboxes_ibfk_1 FOREIGN KEY (domain_id) REFERENCES domains (id) ON DELETE CASCADE ON UPDATE CASCADE;
CREATE TABLE vacation_notify (
  on_vacation varchar(255) NOT NULL,
  notified varchar(255) NOT NULL,
  notified_at datetime NOT NULL,
  PRIMARY KEY (on_vacation(100),notified(100)),
  KEY notified_at (notified_at)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



