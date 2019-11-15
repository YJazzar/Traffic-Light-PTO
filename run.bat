
@echo off
cls
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "filename=./bin/BUILD_%YY%-%MM%-%DD%_%HH%.%Min%.%Sec%.out"

:: To clean
if "%1"=="-clean" goto clean

:: Force clean: Deletes all binary files
if "%1"=="-fclean" goto forceclean
        
:: Compiles the lastest file only | "%1"=="-c"
if "%1"=="-compile" goto compile
if "%1"=="-c" goto compile

:: Runs the last compile only
if "%1"=="-run" goto run
if "%1"=="-r" goto run

:: Cleans, Compiles, and runs in one command
if "%1"=="-d" goto quietclean

goto error

:run 
    echo Getting latest build file...
    cd bin
    for /f %%I in ('dir *.* /b /o:-d') do (
        @echo Running file: ./bin/%%I
        vvp %%I
        echo Run Completed!
        set "filename2=./bin/%%I"
        cd ..
        goto end
    ) 
    

:clean
    echo Cleaning binaries...
    cd bin
    for /f "skip=3 eol=: delims=" %%F in ('dir /b /o-d *.out') do @del "%%F"
    cd ..
    echo Binaries Cleaned!
    goto end

:quietclean
    echo Cleaning binaries...
    cd bin
    for /f "skip=2 eol=: delims=" %%F in ('dir /b /o-d *.out') do @del "%%F"
    cd ..
    echo Binaries Cleaned!
    goto default

:forceclean
    echo Force cleaning ALL binaries...
    cd bin
    for /f %%F in ('dir /b /o-d *.out') do @del "%%F"
    cd ..
    echo Binaries Cleaned!
    goto end

:compile
    echo Compiling source files...
    iverilog -o "%filename%" *.v 
    echo Compile Completed!
    goto end

:default
    :: Compiles and runs the file in one step
    echo Compiling source files...
    iverilog -o "%filename%" *.v 
    echo Running file: %filename%
    vvp "%filename%"
    echo Run Completed!
    goto end
    
:error 
    echo Flag error detected! Exiting...

:end