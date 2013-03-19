#!/usr/bin/env bash

psql << EOF
create role fivesecondcoder with createdb login password 'mNiVc3t3dyneTD8C';
EOF
