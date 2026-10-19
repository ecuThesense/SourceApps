# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "/home/pavel/neovim-0.12.5/.deps/build/src/treesitter_query")
  file(MAKE_DIRECTORY "/home/pavel/neovim-0.12.5/.deps/build/src/treesitter_query")
endif()
file(MAKE_DIRECTORY
  "/home/pavel/neovim-0.12.5/.deps/build/src/treesitter_query-build"
  "/home/pavel/neovim-0.12.5/.deps/build"
  "/home/pavel/neovim-0.12.5/.deps/build/tmp"
  "/home/pavel/neovim-0.12.5/.deps/build/src/treesitter_query-stamp"
  "/home/pavel/neovim-0.12.5/.deps/build/downloads/treesitter_query"
  "/home/pavel/neovim-0.12.5/.deps/build/src/treesitter_query-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/pavel/neovim-0.12.5/.deps/build/src/treesitter_query-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/pavel/neovim-0.12.5/.deps/build/src/treesitter_query-stamp${cfgdir}") # cfgdir has leading slash
endif()
