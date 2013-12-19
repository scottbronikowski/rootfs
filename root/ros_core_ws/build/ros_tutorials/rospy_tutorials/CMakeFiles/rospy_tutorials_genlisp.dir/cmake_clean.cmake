FILE(REMOVE_RECURSE
  "CMakeFiles/rospy_tutorials_genlisp"
  "/root/ros_core_ws/devel/share/common-lisp/ros/rospy_tutorials/msg/Floats.lisp"
  "/root/ros_core_ws/devel/share/common-lisp/ros/rospy_tutorials/msg/HeaderString.lisp"
  "/root/ros_core_ws/devel/share/common-lisp/ros/rospy_tutorials/srv/AddTwoInts.lisp"
  "/root/ros_core_ws/devel/share/common-lisp/ros/rospy_tutorials/srv/BadTwoInts.lisp"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/rospy_tutorials_genlisp.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
