FILE(REMOVE_RECURSE
  "CMakeFiles/diagnostic_msgs_genpy"
  "/root/ros_core_ws/devel/lib/python2.7/dist-packages/diagnostic_msgs/msg/_DiagnosticArray.py"
  "/root/ros_core_ws/devel/lib/python2.7/dist-packages/diagnostic_msgs/msg/_DiagnosticStatus.py"
  "/root/ros_core_ws/devel/lib/python2.7/dist-packages/diagnostic_msgs/msg/_KeyValue.py"
  "/root/ros_core_ws/devel/lib/python2.7/dist-packages/diagnostic_msgs/srv/_SelfTest.py"
  "/root/ros_core_ws/devel/lib/python2.7/dist-packages/diagnostic_msgs/msg/__init__.py"
  "/root/ros_core_ws/devel/lib/python2.7/dist-packages/diagnostic_msgs/srv/__init__.py"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/diagnostic_msgs_genpy.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
