import std/os/process
import std/num/int64

extern import {
  c file "lib.c"
}

extern listen(port: ssize_t) : console ssize_t {
  c "kk_listen"
}

extern accept(sockfd: ssize_t) : console ssize_t {
  c inline "accept(#1, (struct sockaddr *)NULL, NULL)"
}

extern read_to(connfd: ssize_t, ^buf: vector<char>) : console ssize_t {
  c "kk_read_to"
}

extern write(connfd: ssize_t, ^buf: vector<char>, len: ssize_t): console ssize_t {
  c inline "write(#1, &#2, #3)"
}
