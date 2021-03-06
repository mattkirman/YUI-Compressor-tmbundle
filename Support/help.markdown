The YUI Compressor bundle enables easy compression of Javascript and CSS files using the [YUI Compressor](http://developer.yahoo.com/yui/compressor/), from within TextMate.


# Setup

There are 3 steps to getting everything working:

1. [Download the YUI Compressor](http://yuilibrary.com/downloads/#yuicompressor).

2. Unzip the YUI Compressor and copy the `.jar` file from the to a location of your choosing (make a note of where you saved it).

3. Open the `Preferences...` item in this bundle and replace the text `/absolute/path/to/yui-compressor.jar` with the actual path to your `.jar` file. __It must be an absolute path, `~/` won't work__.


# Usage

Select the files you want to run through the YUI Compressor in the Project Drawer and execute the command using &#x21E7;&#8984;Y (cmd-shift-Y)

The compressed files share the same path as the original files, with the addition of `.min` before the file extension. For example:

`my_js_file.js` becomes `my_js_file.min.js`
`my_css_file.css` becomes `my_css_file.min.css`

You can compress more than one file at the same time, just select all the files you want to compress in your Project Drawer before hitting `Compress`.

__Existing files with the same name will be overwritten without warning.__


# About

Author: Matt Kirman <<http://twitter.com/mattkirman>>  

Downloads: <http://github.com/mattkirman/YUI-Compressor-tmbundle/downloads>