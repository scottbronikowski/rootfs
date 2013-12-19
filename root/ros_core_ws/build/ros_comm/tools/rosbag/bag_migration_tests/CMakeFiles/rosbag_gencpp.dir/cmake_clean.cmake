FILE(REMOVE_RECURSE
  "CMakeFiles/rosbag_gencpp"
  "/root/ros_core_ws/devel/include/rosbag/Constants.h"
  "/root/ros_core_ws/devel/include/rosbag/Converged.h"
  "/root/ros_core_ws/devel/include/rosbag/MigratedAddSub.h"
  "/root/ros_core_ws/devel/include/rosbag/MigratedExplicit.h"
  "/root/ros_core_ws/devel/include/rosbag/MigratedImplicit.h"
  "/root/ros_core_ws/devel/include/rosbag/MigratedMixed.h"
  "/root/ros_core_ws/devel/include/rosbag/PartiallyMigrated.h"
  "/root/ros_core_ws/devel/include/rosbag/Renamed4.h"
  "/root/ros_core_ws/devel/include/rosbag/Simple.h"
  "/root/ros_core_ws/devel/include/rosbag/SimpleMigrated.h"
  "/root/ros_core_ws/devel/include/rosbag/SubUnmigrated.h"
  "/root/ros_core_ws/devel/include/rosbag/Unmigrated.h"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/rosbag_gencpp.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
