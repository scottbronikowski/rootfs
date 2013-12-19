FILE(REMOVE_RECURSE
  "../msg_gen"
  "../srv_gen"
  "../src/tf/msg"
  "../src/tf/srv"
  "CMakeFiles/test_bin_cache_unittest"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/test_bin_cache_unittest.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
