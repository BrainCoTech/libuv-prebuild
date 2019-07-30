@echo off
setlocal
cd %~dp0
set ARCH=x64

goto :main

:echo_y
    echo.
    echo [93m%*[0m
goto :eof

:main
    del *.exe *.obj

    set src=main.c
    set includes=..\..\libuv\include
    set libs=advapi32.lib iphlpapi.lib psapi.lib user32.lib userenv.lib ws2_32.lib

    rem MSVC environment
    call :echo_y [win] Environment initialized for: '%ARCH%'
    call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" %ARCH%

    rem 1. static
    call :echo_y [win] build test with static library
    call cl /nologo /c /MD /I%includes% %src% /Fomain.obj
    call link /nologo main.obj ..\x64\static\uv.lib %libs% /out:test-static.exe

    rem Alternative: cl + link
    rem call cl /nologo /MD ^
    rem         %src% /I%includes% %libs% ..\x64\static\uv.lib ^
    rem         /link /out:test-static.exe

    call :echo_y [win] run static test
    call test-static.exe

    rem 2. shared
    call :echo_y [win] build test with shared library
    call link /nologo main.obj ..\x64\shared\uv.lib %libs% /out:test-shared.exe

    call :echo_y [win] run shared test
    set PATH=%PATH%;%CD%\..\x64\shared
    call test-shared.exe

    del *.obj *.exe
goto :eof
