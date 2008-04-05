= pastiepacker

* http://pastiepacker.rubyforge.org

== DESCRIPTION:

Prepare to pack or unpack piles of files with the pastiepacker.

== SYNOPSIS:

To pack a folder: +pastiepacker+

Packing options:
    
    -f, --format=FORMAT       Possess pasties with a particular persona
                              Supported formats:
                              c++, css, diff, html_rails, html, 
                              javascript, php, plain_text, python, 
                              ruby, ruby_on_rails, sql, shell-unix-generic
                              Default: ruby
    -m, --message=MESSAGE     Promotional passage for your pastie
    -p, --private             Posted pasties are private
                              Ignored for unpacking
    -s, --stdout              Prints packed pasties instead of posting
    -H, --no-header           Prevents placing pastiepacker promotion in pasties
                              That is, no 'about:' section is added to the top of pasties
    -h, --help                Show this help message.                                     
    
To only pack a selection of files ending with *txt* you can pass a list of file names via STDIN: 

    find * | grep "txt$" | pastiepacker

It outputs the url of the prepared pastie, so you can pipe it to xargs:

    pastiepacker | xargs open

To unpack a packed pastie: pastiepacker http://pastie.caboo.se/175183
- This unpacks the files into a subfolder 175138/
To unpack a private pastie: pastiepacker http://pastie.caboo.se/private/5hwfheniddqmyasmfcxaw
- This unpacks the files into a subfolder 5hwfheniddqmyasmfcxaw/


== REQUIREMENTS:

* ruby
* rubygems

To test if you have these, the following should work:

  gem env

== INSTALL:

* sudo gem install pastiepacker

== LICENSE:

(The MIT License)

Copyright (c) 2008 Dr Nic Williams

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.