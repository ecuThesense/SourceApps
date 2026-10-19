# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "/home/pavel/neovim-0.12.5/.deps/build/src/utf8proc")
  file(MAKE_DIRECTORY "/home/pavel/neovim-0.12.5/.deps/build/src/utf8proc")
endif()
file(MAKE_DIRECTORY
  "/home/pavel/neovim-0.12.5/.deps/build/src/utf8proc-build"
  "/home/pavel/neovim-0.12.5/.deps/build"
  "/home/pavel/neovim-0.12.5/.deps/build/tmp"
  "/home/pavel/neovim-0.12.5/.deps/build/src/utf8proc-stamp"
  "/home/pavel/neovim-0.12.5/.deps/build/downloads/utf8proc"
  "/home/pavel/neovim-0.12.5/.deps/build/src/utf8proc-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/pavel/neovim-0.12.5/.deps/build/src/utf8proc-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/pavel/neovim-0.12.5/.deps/build/src/utf8proc-stamp${cfgdir}") # cfgdir has leading slash
endif()
