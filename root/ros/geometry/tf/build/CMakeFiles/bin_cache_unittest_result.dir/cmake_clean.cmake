FILE(REMOVE_RECURSE
  "../msg_gen"
  "../srv_gen"
  "../src/tf/msg"
  "../src/tf/srv"
  "CMakeFiles/bin_cache_unittest_result"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/bin_cache_unittest_result.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
