FILE(REMOVE_RECURSE
  "../msg_gen"
  "../srv_gen"
  "../src/tf/msg"
  "../src/tf/srv"
  "CMakeFiles/pyunit_test_testPython.py"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/pyunit_test_testPython.py.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
