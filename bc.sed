#!/bin/sed -rf
s/.*/ & /
:start
s/([^[:digit:]])0\*[0-9]+([^[:digit:]])/\10\2/g
s/([^[:digit:]])[0-9]+\*0([^[:digit:]])/\10\2/g
s/([^[:digit:]])1\*/\1/g
s/\*1([^[:digit:]])/\1/g
s/([^[:digit:]])0+\+/\1/g
s/([^[:digit:]])0+([1-9])/\1\2/g
s/\(([0-9]+)\)/\1/g
/([^[:digit:]])([0-9]+)\*([0-9]+)([^[:digit:]])/{
  s//\1(\2%*\3+\3)\4/
  bdecr
}
/([^[:digit:]])([0-9]+)\+([0-9]+)([^[:digit:]])/{
  s//\1\2@+\3@\4/
  badd
}
/([^[:digit:]])([0-9]+)-([0-9]+)([^[:digit:]])/{
  # Reverse minus
  s//\1\3@-\2@\4/
  badd
}
s/^ (.*) $/\1/
b trampoline

:add
/0@(.*)([0-9])@/{
  s//@0\1@\2/
  badd
}

/([^[:digit:]])([0-9]+)@(.*)-0?@([0-9]+)/{
  s//\1-(\2\3-\4)/
  bstart
}

/([^[:digit:]])@.*[+-](.*)@/{
  s//\1\2/
  bstart
}

s/@(.*-.*)@/%@\1%@/
s/@(.*\+.*)@/%@\1@/
:decr
s/0%/%9/g;tdecr
s/1%/0/g
s/2%/1/g
s/3%/2/g
s/4%/3/g
s/5%/4/g
s/6%/5/g
s/7%/6/g
s/8%/7/g
s/9%/8/g

s/@(.*\+.*)@/@\1%@/
:incr
s/9%/%0/g;tincr
s/0%/1/g
s/1%/2/g
s/2%/3/g
s/3%/4/g
s/4%/5/g
s/5%/6/g
s/6%/7/g
s/7%/8/g
s/8%/9/g
s/%/1/g

/@/badd
b start

:trampoline
