#!/bin/bash

# common.sh
# dUsefulStuff
#
# Created by Derek Clarkson on 26/08/10.
# Copyright 2010 Derek Clarkson. All rights reserved.

assertSet() {
    : ${!1:? "$1 has not been set, aborting."}
}

