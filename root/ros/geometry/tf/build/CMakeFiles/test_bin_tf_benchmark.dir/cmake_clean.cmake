FILE(REMOVE_RECURSE
  "../msg_gen"
  "../srv_gen"
  "../src/tf/msg"
  "../src/tf/srv"
  "CMakeFiles/test_bin_tf_benchmark"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/test_bin_tf_benchmark.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
