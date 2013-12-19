FILE(REMOVE_RECURSE
  "CMakeFiles/rospy_tutorials_genpy"
  "/root/ros_core_ws/devel/lib/python2.7/dist-packages/rospy_tutorials/msg/_Floats.py"
  "/root/ros_core_ws/devel/lib/python2.7/dist-packages/rospy_tutorials/msg/_HeaderString.py"
  "/root/ros_core_ws/devel/lib/python2.7/dist-packages/rospy_tutorials/srv/_AddTwoInts.py"
  "/root/ros_core_ws/devel/lib/python2.7/dist-packages/rospy_tutorials/srv/_BadTwoInts.py"
  "/root/ros_core_ws/devel/lib/python2.7/dist-packages/rospy_tutorials/msg/__init__.py"
  "/root/ros_core_ws/devel/lib/python2.7/dist-packages/rospy_tutorials/srv/__init__.py"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/rospy_tutorials_genpy.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
