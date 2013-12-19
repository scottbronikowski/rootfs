FILE(REMOVE_RECURSE
  "CMakeFiles/nav_msgs_gencpp"
  "/root/ros_core_ws/devel/include/nav_msgs/GridCells.h"
  "/root/ros_core_ws/devel/include/nav_msgs/MapMetaData.h"
  "/root/ros_core_ws/devel/include/nav_msgs/OccupancyGrid.h"
  "/root/ros_core_ws/devel/include/nav_msgs/Odometry.h"
  "/root/ros_core_ws/devel/include/nav_msgs/Path.h"
  "/root/ros_core_ws/devel/include/nav_msgs/GetMap.h"
  "/root/ros_core_ws/devel/include/nav_msgs/GetPlan.h"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/nav_msgs_gencpp.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
