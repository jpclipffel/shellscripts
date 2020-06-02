#!/bin/bash


function nmap_discover_fast() {
    test -z "${1}" && echo "Usage: nmap_fast <ip/range>" && return 1;
    nmap -sn ${1}
}


function nmap_discover() {
    test -z "${1}" && echo "Usage: nmap_fast <ip/range>" && return 1;
    nmap -sn -PA21,22,25,3389 ${1}
}
