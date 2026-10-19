file(REMOVE_RECURSE
  "CMakeFiles/treesitter"
  "CMakeFiles/treesitter-complete"
  "build/src/treesitter-stamp/treesitter-build"
  "build/src/treesitter-stamp/treesitter-configure"
  "build/src/treesitter-stamp/treesitter-download"
  "build/src/treesitter-stamp/treesitter-install"
  "build/src/treesitter-stamp/treesitter-mkdir"
  "build/src/treesitter-stamp/treesitter-patch"
  "build/src/treesitter-stamp/treesitter-update"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/treesitter.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
