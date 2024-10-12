#ifndef CONFIG_H
#define CONFIG_H
// Include this header only under the LLVM source tree.
// This is a private header.
/* Exported configuration */
#include "llvm/Config/llvm-config.h"
/* Bug report URL. */
#define BUG_REPORT_URL "https://bugs.llvm.org/"
/* Define to 1 to enable backtraces, and to 0 otherwise. */
#if defined(LLVM_PLATFORM_LINUX) || defined(LLVM_PLATFORM_WINDOWS)
#define ENABLE_BACKTRACES 1
#else
#define ENABLE_BACKTRACES 0
#endif
/* Define to 1 to enable crash overrides, and to 0 otherwise. */
#if defined(LLVM_PLATFORM_LINUX) || defined(LLVM_PLATFORM_WINDOWS)
#define ENABLE_CRASH_OVERRIDES 1
#else
#define ENABLE_CRASH_OVERRIDES 0
#endif
/* Define to 1 to enable crash memory dumps, and to 0 otherwise. */
#if defined(LLVM_PLATFORM_WINDOWS)
#define LLVM_ENABLE_CRASH_DUMPS 1
#else
#define LLVM_ENABLE_CRASH_DUMPS 0
#endif
/* Define to 1 to prefer forward slashes on Windows, and 0 to prefer backslashes. */
#if defined(LLVM_PLATFORM_WINDOWS)
#define LLVM_WINDOWS_PREFER_FORWARD_SLASH 1
#else
#define LLVM_WINDOWS_PREFER_FORWARD_SLASH 0
#endif
/* Define to 1 if you have the `backtrace' function. */
#if defined(LLVM_PLATFORM_LINUX)
#define HAVE_BACKTRACE 1
#define BACKTRACE_HEADER <execinfo.h>
#else
#define HAVE_BACKTRACE 0
#define BACKTRACE_HEADER <>
#endif
/* Define to 1 if you have the <CrashReporterClient.h> header file. */
#if defined(LLVM_PLATFORM_MAC)
#define HAVE_CRASHREPORTERCLIENT_H 1
#else
#define HAVE_CRASHREPORTERCLIENT_H 0
#endif
/* can use __crashreporter_info__ */
#if defined(LLVM_PLATFORM_MAC)
#define HAVE_CRASHREPORTER_INFO 1
#else
#define HAVE_CRASHREPORTER_INFO 0
#endif
/* Define to 1 if you have the declaration of `arc4random'. */
#if defined(LLVM_PLATFORM_BSD)
#define HAVE_DECL_ARC4RANDOM 1
#else
#define HAVE_DECL_ARC4RANDOM 0
#endif
/* Define to 1 if you have the declaration of `FE_ALL_EXCEPT'. */
#if defined(LLVM_PLATFORM_LINUX) || defined(LLVM_PLATFORM_BSD)
#define HAVE_DECL_FE_ALL_EXCEPT 1
#else
#define HAVE_DECL_FE_ALL_EXCEPT 0
#endif
/* Define to 1 if you have the declaration of `FE_INEXACT'. */
#if defined(LLVM_PLATFORM_LINUX) || defined(LLVM_PLATFORM_BSD)
#define HAVE_DECL_FE_INEXACT 1
#else
#define HAVE_DECL_FE_INEXACT 0
#endif
/* Define to 1 if you have the declaration of `strerror_s'. */
#if defined(LLVM_PLATFORM_WINDOWS)
#define HAVE_DECL_STRERROR_S 1
#else
#define HAVE_DECL_STRERROR_S 0
#endif
/* Define to 1 if you have the <dlfcn.h> header file. */
#if defined(LLVM_PLATFORM_LINUX) || defined(LLVM_PLATFORM_MAC)
#define HAVE_DLFCN_H 1
#else
#define HAVE_DLFCN_H 0
#endif
/* Define if dlopen() is available on this LLVM_PLATFORM. */
#if defined(LLVM_PLATFORM_LINUX) || defined(LLVM_PLATFORM_MAC)
#define HAVE_DLOPEN 1
#else
#define HAVE_DLOPEN 0
#endif
/* Define if dladdr() is available on this LLVM_PLATFORM. */
#if defined(LLVM_PLATFORM_LINUX) || defined(LLVM_PLATFORM_MAC)
#define HAVE_DLADDR 1
#else
#define HAVE_DLADDR 0
#endif
/* Define to 1 if you have the `getpagesize' function. */
#if defined(LLVM_PLATFORM_LINUX) || defined(LLVM_PLATFORM_MAC)
#define HAVE_GETPAGESIZE 1
#else
#define HAVE_GETPAGESIZE 0
#endif
/* Define to 1 if you have the `pthread' library (-lpthread). */
#if defined(LLVM_PLATFORM_LINUX) || defined(LLVM_PLATFORM_MAC)
#define HAVE_LIBPTHREAD 1
#else
#define HAVE_LIBPTHREAD 0
#endif
/* Define to 1 if you have the `pthread_getname_np' function. */
#if defined(LLVM_PLATFORM_LINUX)
#define HAVE_PTHREAD_GETNAME_NP 1
#else
#define HAVE_PTHREAD_GETNAME_NP 0
#endif
/* Define to 1 if you have the <mach/mach.h> header file. */
#if defined(LLVM_PLATFORM_MAC)
#define HAVE_MACH_MACH_H 1
#else
#define HAVE_MACH_MACH_H 0
#endif
/* Define to 1 if you have the <unistd.h> header file. */
#if defined(LLVM_PLATFORM_LINUX) || defined(LLVM_PLATFORM_MAC)
#define HAVE_UNISTD_H 1
#else
#define HAVE_UNISTD_H 0
#endif
// Add more LLVM_PLATFORM checks as needed, converting cmakedefines to LLVM_PLATFORM defines
#endif // CONFIG_H