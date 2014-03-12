%%% This file is part of the dictionaries-common package.
%%% It has been automatically generated.
%%% DO NOT EDIT!

#ifexists aspell_add_dictionary
  if (_slang_utf8_ok) {
    aspell_add_dictionary (
      "american",
      "en_US",
      "",
      "'",
      "");
    aspell_add_dictionary (
      "british",
      "en_GB",
      "",
      "'",
      "");
    aspell_add_dictionary (
      "canadian",
      "en_CA",
      "",
      "'",
      "");
    aspell_add_dictionary (
      "english",
      "en",
      "",
      "'",
      "");
  } else {
  aspell_add_dictionary (
    "american",
    "en_US",
    "",
    "'",
    "");
  aspell_add_dictionary (
    "british",
    "en_GB",
    "",
    "'",
    "");
  aspell_add_dictionary (
    "canadian",
    "en_CA",
    "",
    "'",
    "");
  aspell_add_dictionary (
    "english",
    "en",
    "",
    "'",
    "");
  }
#endif

#ifexists ispell_add_dictionary
  ispell_add_dictionary (
    "american",
    "american",
    "",
    "'",
    "",
    "-B -d american");
#endif
