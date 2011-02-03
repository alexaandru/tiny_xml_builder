tiny_xml_builder
    by Alexandru Ungur
    http://github.com/alexaandru/tiny_xml_builder

== DESCRIPTION:

A very simple XML builder class.
I wanted something really simple that I could easily extend
myself later on if I needed to. Ironically, in four years 
since I created it, I never needed to extend it :-)
I figured, it may as well work for others in that case, so 
here it is.

== ACKNOWLEDGEMENTS:

A big thanks to Jim Weirich for his great advices on Ruby-talk.
The BlankSlate "mechanism" is copied directly from his tips at:
http://onestepback.org/index.cgi/Tech/Ruby/BlankSlate.rdoc

== FEATURES/PROBLEMS:

* You cannot have XML elements named __id__, __send__, 
  method_missing, instance_eval or respond_to as those
  are NOT undefined by BlankSlate mechanism;

* There are other limitations related to "implicit receiver"
  calls, e.g.:

    puts TinyXml::Builder.new.foo {|f| f.p 'bar'} # explicit receiver for 'p'

        will result in:

    <foo>
      <p>bar</p>
    </foo>

        while:
    
    puts TinyXml::Builder.new.foo { p 'bar' } # implicit receiver for 'p'

        will result in:

    "bar"
    <foo>
    </foo>

        as "p" method exists in outer scope and does an entirely
        different thing than what (missing) methods of TinyXml do.

== SYNOPSIS:
 require 'tiny_xml_builder'

 builder = TinyXml::Builder.new
 builder.html do |xhtml|
   xhtml.head do |head|
     head.title 'Hello World'
     head.meta :name => :keywords, :content => 'hello, world' 
     head.meta :name => :description, :content => 'hello world sample usage for XML class'
   end
   xhtml.body do |body|
     body.div :id => 'main' do |div_main|
       div_main.h1 "Hello World"
       div_main.p "Hello HTML world", "from XML"
     end
   end
 end

 puts builder

 # alternatively

 puts TinyXml::Builder.new.html {
   head {
     title 'Hello World'
     meta :name => :keywords, :content => 'hello, world' 
     meta :name => :description, :content => 'hello world sample usage for XML class'
   }

   body {
     div(:id => 'main') { |div|
       div.h1 "Hello World"
       div.p "Hello HTML world", "from XML"
     }
   }
 }

 # =>

 <html>
   <head>
     <title>Hello World</title>
     <meta name="keywords" content="hello, world" />
     <meta name="description" content="hello world sample usage for XML class" />
   </head>
   <body>
     <div id="main">
       <h1>Hello World</h1>
       <p>Hello HTML world</p>
       <p>from XML</p>
     </div>
   </body>
 </html>

== REQUIREMENTS:

* NONE

== INSTALL:

sudo gem install tiny_xml_builder

== LICENSE:

(The MIT License)

Copyright (c) 2010 Alexandru Ungur, except for BlankSlate
mechanism (line 2 in lib/tiny_xml_builder.rb) which is
Copyright (c) Jim Weirich.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
