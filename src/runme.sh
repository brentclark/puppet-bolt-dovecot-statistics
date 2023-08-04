#!/bin/bash
#
#
bolt plan run vagrant_bolt_dovecot_statistics::dovecot \
  --clear-cache \
  --run-as root \
  -t linux
