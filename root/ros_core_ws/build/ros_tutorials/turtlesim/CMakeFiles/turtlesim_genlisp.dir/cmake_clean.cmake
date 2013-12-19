FILE(REMOVE_RECURSE
  "CMakeFiles/turtlesim_genlisp"
  "/root/ros_core_ws/devel/share/common-lisp/ros/turtlesim/msg/Color.lisp"
  "/root/ros_core_ws/devel/share/common-lisp/ros/turtlesim/msg/Pose.lisp"
  "/root/ros_core_ws/devel/share/common-lisp/ros/turtlesim/msg/Velocity.lisp"
  "/root/ros_core_ws/devel/share/common-lisp/ros/turtlesim/srv/Kill.lisp"
  "/root/ros_core_ws/devel/share/common-lisp/ros/turtlesim/srv/SetPen.lisp"
  "/root/ros_core_ws/devel/share/common-lisp/ros/turtlesim/srv/Spawn.lisp"
  "/root/ros_core_ws/devel/share/common-lisp/ros/turtlesim/srv/TeleportAbsolute.lisp"
  "/root/ros_core_ws/devel/share/common-lisp/ros/turtlesim/srv/TeleportRelative.lisp"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/turtlesim_genlisp.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
