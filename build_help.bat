@ECHO OFF

pushd %~dp0

set VENVDIR=%~dp0_venv
set PYTHONEXE=%VENVDIR%\Scripts\python.exe
set SPHINXEXE=%VENVDIR%\Scripts\sphinx-build.exe
set HHCEXE=%~dp0_htmlhelp\hhc.exe

set SOURCEDIR=.
set BUILDDIR=_build

rem "build_help.bat PROJECT_NAME [AUTHOR]"
if [%1]==[] goto help
set a=%1
set b=%2
set PROJECT_NAME=%a:"=%
set AUTHOR=%b:"=%
if [%2]==[] set AUTHOR=%PROJECT_NAME%

rem "Replace the conf.py project name and author"
set SPHINXOPTS=-D project="%PROJECT_NAME%"
set SPHINXOPTS=%SPHINXOPTS% -D copyright="%date:~10,4%, %AUTHOR%"
set SPHINXOPTS=%SPHINXOPTS% -D author="%AUTHOR%"
set SPHINXOPTS=%SPHINXOPTS% -D htmlhelp_basename="%PROJECT_NAME%"
set SPHINXOPTS=%SPHINXOPTS% -D html_title="%PROJECT_NAME%"

rem "Specify the HTML Help Project (*.hhp) path"
set HHP="%BUILDDIR%\htmlhelp\%PROJECT_NAME%.hhp"

if not exist %PYTHONEXE% (
    echo.--- Installing virtual environment ---
    python.exe -m venv _venv
)
if not exist %SPHINXEXE% (
    echo.--- Installing sphinx ---
    %PYTHONEXE% -m pip install -r requirements.txt
)
if exist %BUILDDIR% (
    echo.--- Removing build directory ---
    rmdir /s /q %BUILDDIR%
)
if exist %SPHINXEXE% (
    echo.--- Building static HTML files ---
    %SPHINXEXE% -M html %SOURCEDIR% %BUILDDIR% %SPHINXOPTS%
    if exist %HHCEXE% (
        echo.--- Building HTML Help CMH file ---
        %SPHINXEXE% -M htmlhelp %SOURCEDIR% %BUILDDIR% %SPHINXOPTS%
        %HHCEXE% %HHP%
    )
)
goto end

:help
echo.ERROR: PROJECT_NAME not specified.
echo.
echo.Usage: build_help.bat PROJECT_NAME [AUTHOR]
echo.
echo.    PROJECT_NAME    Project title and chm filename
echo.    AUTHOR          (Optional) Copyright author [Use PROJECT_NAME]
echo.
echo.Generate HTML and CHM help files from reStructuredText files 
echo.using Python, Sphinx and HTML Help Workshop for Windows.
echo.
echo.Example: build_help.bat "My Project" "Ryan Pacini"
echo.    Outputs: .\_build\html\index.html
echo.    Outputs: .\_build\htmlhelp\My Project.chm
goto end

:end
popd