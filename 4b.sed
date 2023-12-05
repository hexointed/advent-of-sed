#!/bin/sed -rf
:a
N
$!ba
s/$/\n============/
:b
s/\n/b/
H
x
s/b.*//
x
s/b/\n/
:x
tx
s/[^:]*://
:c
s/^(u*) +([0-9]+) ([^\n]*\|[^\n]* )\2([^[:digit:]])/u\1 \2 \3\4/;tc
s/^(u*) +([0-9]+)/\1/;tc
s/^(u*) \|[^\n]*/\1/

s/C/bC/g
:d
s/bC([^\n]*\n)/C\1c\1/
s/u//
/u/{
  bd
}
s/b//g
s/\n//
/Card/bb
x
s/[^:]//g
s/:/1+/g
s/.$//
