#!/bin/sh -e
# Copyright (C) 2004 Bastian Kleineidam <calvin@debian.org>
# The contents of this file are released in the Public Domain
# convert openoffice documents to text
# suitable for full-text indexing
# usage: oototext.sh <openoffice file>

# requires: unzip, xsltproc

case "$1" in
*.sxd|*.sxw|*.sxc|*.sxi)
    unzip -p "$1" meta.xml | xsltproc --novalid oometa.xsl -
    unzip -p "$1" content.xml | xsltproc --novalid oocontent.xsl -
    break
    ;;
*)
    echo "Unsupported file type $1"
    exit 1
    break
    ;;
esac
