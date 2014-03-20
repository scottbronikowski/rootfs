#!/bin/bash
for i in {1..10000}
do
    echo "***Starting test $i"
    /root/test_code/flycapture/bin/CustomImageEx
    echo "***Completed test $i"
done
    
