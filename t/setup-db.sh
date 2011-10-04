#!/bin/sh
mysql -uroot -e 'DROP DATABASE IF EXISTS intern_bookmark_test'
mysql -uroot -e 'CREATE DATABASE intern_bookmark_test'
mysql -uroot intern_bookmark_test < db/schema.sql
