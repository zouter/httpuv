# Build against mingw-w64 build of libuv 1.8.0
if(!file.exists("../windows/libuv-1.8.0/include/uv.h")){
  if(getRversion() < "3.3.0") setInternet2()
  download.file("https://github.com/jcheng5/libuv/archive/v1.8.0.zip", "lib.zip", quiet = TRUE)
  dir.create("../windows", showWarnings = FALSE)
  unzip("lib.zip", exdir = "../windows")
  unlink("lib.zip")
}

