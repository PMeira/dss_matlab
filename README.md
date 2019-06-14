# DSS MATLAB: an unofficial MATLAB package for EPRI's OpenDSS

This is version of a set of MATLAB classes that expose the DSS C-API library with the same structure as the COM object, with the same as extensions as DSS Python. This is the equivalent of DSS Python and DSS Sharp for MATLAB usage.

Related projects: 
- [`OpenDSS`](https://sourceforge.net/projects/electricdss/): The main OpenDSS project, maintained by EPRI.
- [`DSS C-API`](http://github.com/dss-extensions/dss_capi): Custom OpenDSS C-API library, which also includes some patches.
- [`DSS Python`](http://github.com/dss-extensions/dss_python): Python bindings that mimics the official COM interface.
- [`OpenDSSDirect.py`](http://github.com/dss-extensions/OpenDSSDirect.py): More pythonic bindings and useful tools.
- [`DSS Sharp`](http://github.com/dss-extensions/dss_sharp/): .NET assembly to use the native DLL, mimics the COM object as used in .NET.

The first non-preview version, 0.10.3, is expected to cover most of the COM functions and classes. If you find a missing function or unexpected behavior, please open an issue on GitHub to both help us track and hopefully fix it, and also inform other users.

## Usage

1. Download a package from the [releases page](https://github.com/dss-extensions/dss_matlab/releases).

2. Add the folder containing `+DSS_MATLAB` to your MATLAB path.

3. Instantiate `DSS_MATLAB.IDSS`. For example:

```matlab
dss = DSS_MATLAB.IDSS;
```

4. If you find issues or missing features, feel free to [open an issue ticket on GitHub](https://github.com/dss-extensions/dss_matlab/issues/new) or email me (pmeira at ieee.org).

If you code is based on `DSSStartup.m` from the examples, in general you only need to replace the `Obj = actxserver('OpenDSSEngine.DSS');` line. That is, update `DSSStartup.m` to:

```matlab
%--------------------------------------------------------------------------
function [Start,Obj,Text] = DSSStartup
    % Function for starting up the DSS
    
    %instantiate the DSS Object
    Obj = DSS_MATLAB.IDSS;
    %
    %Start the DSS.   Only needs to be executed the first time w/in a
    %Matlab session
    Start = Obj.Start(0);

    % Define the text interface
    Text = Obj.Text;    
```

If you want some code to play with, you can use the MATLAB examples from the official OpenDSS distribution, from a local installation (e.g. `C:\OpenDSS\Examples\Matlab`) or from the [official SVN repository](https://sourceforge.net/p/electricdss/code/HEAD/tree/trunk/Distrib/Examples/Matlab/).

[Sandia's GridPV toolbox](https://pvpmc.sandia.gov/applications/gridpv-toolbox/) has been confirmed to work with very minor changes. Note that the toolbox seems to be out-of-date for some features, so don't expect everything to work even with COM (e.g. Google Maps integration seem broken). 

**As a general advice (valid for COM and DSS_MATLAB), avoid using the `get` function without parameters on OpenDSS classes. Some properties like `First` and `Next` used for iteration of elements change the current active element and can lead to misleading data!**

## Known differences and more

We maintain a list of important differences between the official COM implementation and DSS C-API at:

https://github.com/dss-extensions/dss_capi/blob/master/docs/known_differences.md

Most of these apply indirectly to DSS_MATLAB.

The [list of important changes](https://github.com/dss-extensions/dss_capi/blob/master/docs/changelog.md#version-0103) through development is also useful.

## Credits / Acknowlegement

This project is derived from EPRI's OpenDSS and the same style of license (BSD style) is used. As OpenDSS, the project also depends on KLUSolve and SuiteSparse, licensed under the LGPL.

See the [DSS C-API](https://github.com/dss-extensions/dss_capi/) project for more details and source files.

