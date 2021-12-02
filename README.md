# help_html_chm

Customized "Read the Docs" theme to compile Windows HTML Help files (chm) and static HTML pages
using Python + Sphinx + HTML Help Workshop.

## Installation

Manual:

1. Install Python 3.10+
    * Create a python virtual environment: `python.exe -m venv venv`
    * Activate the virtual environment: `venv\\Scripts\\activate.bat`
2. Install Sphinx and Read the Docs theme
    * Install packages: `python.exe -m pip install -r requirements.txt`
        * `Sphinx==4.3.1` - Used to generate the html and html help project files
        * `sphinx-rtd-theme==1.0.0` - Sphinx Read the Docs theme
        * `sphinx-tabs==3.2.0` - Sphinx Extension for tab content
3. Install Windows HTML Help Workshop
    * Run `_htmlhelp\htmlhelp.exe` to install HHW
    * Set the installation directory to the local `_htmlhelp` directory
        * The `hhc.exe` should be located at: `.\\_htmlhelp\\hhc.exe`

Automated:

1. Install Python 3.10+
2. Run `build_help.bat "Demo"` to:
    * Create the virtual environment (`python.exe -m venv _venv`)
    * Install Sphinx and Read the Docs theme (`_venv\\Scripts\\python.exe -m pip install -r requirements.txt`)
    * Compile the static HTML files (`_venv\\Scripts\\sphinx-build.exe -M html . _build`)
    * Compile the Windows HTML Help Project files (`_venv\\Scripts\\sphinx-build.exe -M htmlhelp . _build`) 
    * Compile the HTML Help CHM file (`_htmlhelp\\hhc.exe _build\\htmlhelp\\Project.hhp`)

## Getting Started

Sphinx uses reStructuredText files to compile html files.
Refer to the Sphinx documentation for formatting.
The project comes with the root `index.rst` and `demo\index.rst` to get started.
Add more reStructuredText files and topic sub-directories as needed.

1. Create a root `index.rst` reStructuredText file with:
2. Create sub-directories for different topics
3. Create an `index.rst` in each sub-directory, update the content as necessary
4. Update the root `index.rst` `.. toctree::` to include each sub-directory.

## Build the HTML and CHM help

Once the reStructuredText files are added and the root `.. toctree::` is updated to reference
the sub-directory topics. Create the help files:

Manually:

1. Activate the virtual environment: `venv\\Scripts\\activate.bat`
2. Edit the `conf.py` as needed to update the project name, author, copyright, html_title, etc.
3. Compile the static HTML help files: `_venv\\Scripts\\sphinx-build.exe -M html . _build`
    * Outputs static html files to: `_build\\html\\index.html`
4. Compile the Windows HTML Help Project files: `_venv\\Scripts\\sphinx-build.exe -M htmlhelp . _build`
    * Outputs html help project files to: `_build\\htmlhelp\\PROJECT.hhp`
5. Compile the CHM help file: `_htmlhelp\\hhc.exe _build\\htmlhelp\\PROJECT.hhp`
    * Outputs: `_build\\htmlhelp\\PROJECT.chm`

Automated:

1. Run `build_help.bat "PROJECT_NAME" "AUTHOR"` to:
    * Compile the static HTML files (`_venv\\Scripts\\sphinx-build.exe -M html . _build`)
    * Compile the Windows HTML Help Project files (`_venv\\Scripts\\sphinx-build.exe -M htmlhelp . _build`) 
    * Compile the HTML Help CHM file (`_htmlhelp\\hhc.exe _build\\htmlhelp\\Project.hhp`)

The `build_help.bat PROJECT_NAME [AUTHOR]` uses the `-D setting=value` directives to override the existing
`conf.py` project settings when generating the static HTML and Windows CHM help files.

The output build files are located in the `_build\\html` and `_build\\htmlhelp` directories respectively.
The `_build\\html` directory can be hosted on a webserver (such as github) whereas
the `_build\\htmlhelp\\PROJECT.chm` can be included when distributing an application as a single file.

## Project Example

File structure:

```
\index.rst    - Root index reStructuredText (reference all .. toctree:: sub-topics)
\dir
    \index.rst  - Topic index file
    \subdir
        \index.rst - Sub-Topic index file 
```

The root `index.rst`:

```
### .\index.rst ###
.. Project documentation master file. It should at least
   contain the root `toctree` directive.

Title
=====

The main documentation sections:

.. toctree::
   :maxdepth: 1
   :caption: Tutorials
   :name: sec-learn

   dir/index
   dir/subdir/index
   # Add index paths for each sub-directory topic 
```


