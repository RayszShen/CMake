#!/bin/sh

set -e

# Install development tools.
dnf install \
    --setopt=install_weak_deps=False \
    --setopt=fastestmirror=True \
    --setopt=max_parallel_downloads=10 \
    -y \
    $(grep '^[^#]\+$' /root/iwyu_packages.lst)

cd /root
git clone "https://github.com/include-what-you-use/include-what-you-use.git"
cd include-what-you-use
readonly llvm_full_version="$( clang --version | head -n1 | cut -d' ' -f3 )"
readonly llvm_version="$( echo "$llvm_full_version" | cut -d. -f-1 )"
#FIXME(IWYU): Create clang_19 branch.
#git checkout "clang_$llvm_version"
git checkout d2d092919f2774b5463e236e1ee9d56fb46ceb60 # 2024-10-05
git apply <<EOF
diff --git a/iwyu_driver.cc b/iwyu_driver.cc
index dd4b046..cfd568a 100644
--- a/iwyu_driver.cc
+++ b/iwyu_driver.cc
@@ -249,6 +249,7 @@ bool ExecuteAction(int argc, const char** argv,
                                           /*CodeGenOpts=*/nullptr);

   Driver driver(path, getDefaultTargetTriple(), *diagnostics);
+  driver.ResourceDir = "/usr/lib64/clang/$llvm_full_version";
   driver.setTitle("include what you use");

   // Expand out any response files passed on the command line
EOF
mkdir build
cd build

cmake -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    "-DCMAKE_INSTALL_PREFIX=/usr/local/lib64/llvm-$llvm_version" \
    ..
ninja
DESTDIR=/root/iwyu-destdir ninja install
tar -C /root/iwyu-destdir -cf /root/iwyu.tar .
