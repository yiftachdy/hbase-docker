#!/bin/bash

/opt/hbase/bin/hbase regionserver start > logregion.log 2>&1 &
/opt/hbase/bin/hbase master start > logmaster.log 2>&1 &
sleep 10
/opt/hbase/bin/hbase shell < /create_tables.txt
tail -f logmaster.log
