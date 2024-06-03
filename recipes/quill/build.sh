#!/bin/bash

CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"

cmake ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH:PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX} \
  -DCMAKE_INSTALL_LIBDIR=lib \
  -DCMAKE_BUILD_TYPE=Release \
  -DQUILL_BUILD_TESTS=ON \
  .

# Check if the operating system is macOS
if [[ "$(uname)" != "Darwin" ]]; then
  # If not macOS, run tests
  if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    cmake --build . --target TEST_ArithmeticTypesLogging
    ctest -R arithmetic_types_logging
  fi
fi

cmake --install .
