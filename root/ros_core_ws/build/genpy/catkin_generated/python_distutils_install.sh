#!/bin/sh -x

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

cd "/root/ros_core_ws/src/genpy"

# todo --install-layout=deb per platform
# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
/usr/bin/env \
    PYTHONPATH="/root/ros_core_ws/install/lib/python2.7/dist-packages:/root/ros_core_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/root/ros_core_ws/build" \
    "/usr/bin/python" \
    "/root/ros_core_ws/src/genpy/setup.py" \
    build --build-base "/root/ros_core_ws/build/genpy" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix=/root/ros_core_ws/install --install-scripts=/root/ros_core_ws/install/bin
