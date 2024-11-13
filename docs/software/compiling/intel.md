# Intel compilers

[intel-opt]: https://www.intel.com/content/www/us/en/docs/dpcpp-cpp-compiler/developer-guide-reference/2023-2/optimization-options.html
[intel-debug]: https://www.intel.com/content/www/us/en/docs/dpcpp-cpp-compiler/developer-guide-reference/2023-2/output-debug-and-precompiled-header-options.html
[intel-dev]: https://www.intel.com/content/www/us/en/docs/dpcpp-cpp-compiler/developer-guide-reference/2023-2/optimization-report-options.html 

The Intel compoler suite includes front ends for the C (`icc`), C++
(`icx`), and Fortran (`ifort`) programming languages.

## Choose a version

The Intel compilers are available from the `intel` module. This
module loads the default version of the compiler.

```bash
$ module load intel
```

If you wish to use an older or newer version, you can list the available
version with

```bash
$ module spider intel
```

and then switch to the desired version using

```bash
$ module swap intel intel/<version>
```

## OpenMP Support

OpenMP is turned off by default. You can turn it on using the `-qopenmp` flag.

## Optimization options

:material-help-circle-outline: `man icc` - `man ifort`

The default optimization level of the Intel compiler is `-O2 -fp-model=fast`. Therefore the most essential optimization flags are set by default:

```bash
-O2 -fp-model=fast
```

- the `-O2` option performs nearly all supported optimizations
- the `-fp-model=fast` relax the IEEE specifications for math functions. This option
  can produce incorrect results, don't use this flag if your code is sensitive
  to floating-point optimizations.


- [Intel documentation about optimization options][intel-opt]


## Compiler Feedback

- [Intel documentation about developer options][intel-dev]

## Debugging

To ease a debugging process, it is useful to generate an executable containing
debugging information. For this purpose, you can use the `-g` option.

Most of the time, the debug information works best at low levels of code
optimization, so consider using the `-O0` level. The `-g` options can be
specified on a per-file basis so that only a small part of your application
incurs the debugging penalty.

- [Intel documentation about debug options][intel-debug]
