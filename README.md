# Pandoc for AWS Lambda

This is a binary package and a Node.js wrapper for a precompiled version of [Pandoc](http://pandoc.org/) for the Amazon Linux machine image used by AWS Lambda. It can help you get started quickly with Pandoc inside Lambda functions.

Check out the [Running Pandoc on Lambda Guide](https://claudiajs.com/tutorials/pandoc-lambda.html) for information on how this binary was produced, and how to compile a different version yourself with modified options.

## Usage without Node.js

To use without Node.js, grab the binary from [vendor/pandoc.gz](vendor/pandoc.gz) and upload to Lambda yourself. This is gzipped to save space, so unpack it first before executing.

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

## Local usage

To run this in local tests, define a `PANDOC_PATH` environment variable and set it to your local Pandoc executable. It will then use the provided executable instead of unpacking the Lambda binary

## Version information

Compiled for (`ami-4fffc83`)[https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Images:visibility=public-images;search=amzn-ami-hvm-2017.03.1.20170812-x86_64-gp2;sort=name], for Linux kernel version 4.9.38-16.35.amzn1.x86_64.

```
pandoc 2.2.1
Compiled with pandoc-types 1.17.4.2, texmath 0.11.0.1, skylighting 0.7.1
Default user data directory: /home/ec2-user/.pandoc
Copyright (C) 2006-2018 John MacFarlane
Web:  http://pandoc.org
This is free software; see the source for copying conditions.
There is no warranty, not even for merchantability or fitness
for a particular purpose.
```

### License

To keep things consistent, this library is released under GPL. If this is a problem for you, check out the [Running Pandoc on Lambda Guide](https://claudiajs.com/tutorials/pandoc-lambda.html) for information on how to produce the binary yourself.

Pandoc is free software, released under the GPL. © 2006-2018 John MacFarlane. 
