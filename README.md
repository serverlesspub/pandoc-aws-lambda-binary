# Pandoc for AWS Lambda

This is a binary package and a Node.js wrapper for a precompiled version of [Pandoc](http://pandoc.org/) for the Amazon Linux machine image used by AWS Lambda. It can help you get started quickly with Pandoc inside Lambda functions.

Check out the [Running Pandoc on Lambda Guide](https://claudiajs.com/tutorials/pandoc-lambda.html) for information on how this binary was produced, and how to compile a different version yourself with modified options.

## Usage without Node.js

To use without Node.js, grab the binary from [vendor/pandoc.gz](vendor/pandoc.gz) and upload to Lambda yourself.

## Usage from Node.js

Include the `pandoc-aws-lambda-binary` package using NPM, and make sure to package it with your Lambda function code:

```bash
npm install pandoc-aws-lambda-binary -S
```

Require and call the NPM package function from your Lambda code:


```js
var pandoc = require('pandoc-aws-lambda-binary');

var resultPromise = pandoc(inputFilePath, outputFilePath, additionalOptions);
```

### Options 

* `inputFilePath`: `string` -- file you want to convert
* `outputFilePath`: `string` -- path to save the results
* `additionalOptions`: `array` -- any other options you want to pass to the pandoc executable

The options will be concatenated into a command such as `pandoc inputFilePath -o outputFilePath additionalOptions`.

### Return value

The `pandoc` function is asynchronous and returns a JavaScript Promise, that will be resolved or rejected depending on the results of the command execution.

### Full Example

Check out the [Pandoc S3 Converter Example Project](https://github.com/claudiajs/example-projects/tree/master/pandoc-s3-converter) to see how to wire everything up into a Lambda function.

## Version information

Compiled for `ami-60b6c60a`, for Linux kernel version – 4.1.27-25.49.amzn1.x86_64. 

Pandoc 1.17.2, Compiled with texmath 0.8.6.5, highlighting-kate 0.6.2.1.

Syntax highlighting is supported for the following languages: abc, actionscript, ada, agda, apache, asn1, asp, awk, bash, bibtex, boo, c, changelog, clojure, cmake, coffee, coldfusion, commonlisp, cpp, cs, css, curry, d, diff, djangotemplate, dockerfile, dot, doxygen, doxygenlua, dtd, eiffel, elixir, email, erlang, fasm, fortran, fsharp, gcc, glsl, gnuassembler, go, hamlet, haskell, haxe, html, idris, ini, isocpp, java, javadoc, javascript, json, jsp, julia, kotlin, latex, lex, lilypond, literatecurry, literatehaskell, llvm, lua, m4, makefile, mandoc, markdown, mathematica, matlab, maxima, mediawiki, metafont, mips, modelines, modula2, modula3, monobasic, nasm, noweb, objectivec, objectivecpp, ocaml, octave, opencl, pascal, perl, php, pike, postscript, prolog, pure, python, r, relaxng, relaxngcompact, rest, rhtml, roff, ruby, rust, scala, scheme, sci, sed, sgml, sql, sqlmysql, sqlpostgresql, tcl, tcsh, texinfo, verilog, vhdl, xml, xorg, xslt, xul, yacc, yaml, zsh

### License

To keep things consistent, this library is released under GPL. If this is a problem for you, check out the [Running Pandoc on Lambda Guide](https://claudiajs.com/tutorials/pandoc-lambda.html) for information on how to produce the binary yourself.

Pandoc is free software, released under the GPL. © 2006-2016 John MacFarlane. 
