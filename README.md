# Pandoc for AWS Lambda

This is a precompiled version of [Pandoc](http://pandoc.org/) for the Amazon Linux machine image used by AWS Lambda, deployable as an AWS lambda layer. It can help you get started quickly with Pandoc inside Lambda functions.

## Use within Lambda

You can use a pre-deployed `ARN: arn:aws:lambda:us-east-1:818931230230:layer:pandoc:6` or deploy yourself -- edit Makefile to set your deployment bucket etc, then just run `make deploy`.

The binary will be in `/opt/bin/pandoc` inside your Lambda container.

## Build it yourself

Check out the [Running Pandoc on Lambda Guide](https://claudiajs.com/tutorials/pandoc-lambda.html) for information on how this binary was produced, and how to compile a different version yourself with modified options.

## Version information

Compiled for [`ami-4fffc83`](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Images:visibility=public-images;search=amzn-ami-hvm-2017.03.1.20170812-x86_64-gp2;sort=name), for Linux kernel version 4.9.38-16.35.amzn1.x86_64.

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

To keep things consistent, this library is released under GPL (v2 or later). If this is a problem for you, check out the [Running Pandoc on Lambda Guide](https://claudiajs.com/tutorials/pandoc-lambda.html) for information on how to produce the binary yourself.

Pandoc is free software, released under the GPL. © 2006-2018 John MacFarlane. 
