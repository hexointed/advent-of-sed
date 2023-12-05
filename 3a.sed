#!/bin/sed -rf
h
s/[0-9]/./g
G
s/^/n/g
N
s/\n/ln/g
s/$/l/g
s/^/b/
s/n/a/2
:start
s/[0-9](\.+)a/.\1a/;t start
/[0-9]a|a[0-9]/{
  /[^[:alnum:].][na]|[na][^[:alnum:].]/{
    s/(.*)b(.*[^[:digit:]])([0-9]*)a([0-9]*)/\1\3\4+b\2\3a\4/
    :f1
    s/([0-9]+)a/r\1y/
    s/(r.*)[^.](.*y)/\1.\2/;t f1
    s/r(.*)y/\1a/
    :f2
    s/a([0-9]+)/r\1y/
    s/(r.*)[^.](.*y)/\1.\2/;t f2
    s/r(.*)y/a\1/
    b start
  }
}
/nl/{
  s/(.*)b([^[:alpha:]]*)nl/\1nb/
  $!{
    N
    s/\n//
    s/$/l/
  }
}
/l/{
  s/([an])(.)/\2\1/g;t start
}
s/[a-z]*//g
s/.$//
