FILE(REMOVE_RECURSE
  "../msg_gen"
  "../srv_gen"
  "../src/tf/msg"
  "../src/tf/srv"
  "CMakeFiles/rostest_test_test_broadcaster.launch"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/rostest_test_test_broadcaster.launch.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
