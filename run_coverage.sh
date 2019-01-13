#!/usr/bin/env zsh

set -x
set -e

rm -f coverage.html
rm -f coverage.txt
bazel build //source/...
bazel coverage //source/cpp_native/...

# find bazel-bin/ -executable -type f | grep tests$ | uniq

## Merge then parse
llvm-profdata merge \
              bazel-out/k8-fastbuild/testlogs/source/cpp_native/**/coverage.dat \
               -o aggregate.dat

OBJ_FILES=(-object=bazel-out/k8-fastbuild/bin/source/cpp_native/add/tests/add_tests \
         -object=bazel-out/k8-fastbuild/bin/source/cpp_native/power/tests/power_tests \
         -object=bazel-out/k8-fastbuild/bin/source/cpp_native/multiply/tests/multiply_tests)

llvm-cov show -instr-profile=aggregate.dat  ${OBJ_FILES[*]} > coverage.txt

llvm-cov show --format html -instr-profile=aggregate.dat  ${OBJ_FILES[*]} > coverage.html

llvm-cov report -instr-profile=aggregate.dat ${OBJ_FILES[*]}

echo 'Finished'

# cat coverage.txt
