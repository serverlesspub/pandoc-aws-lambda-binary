# Pandoc Lambda Layer for Amazon Linux 2 AMIs

Static build of Pandoc for Amazon Linux 2, packaged as a Lambda layer. 
Bundles Pandoc 2.7.2.

This application provides a single output, `LayerVersion`, which points to a
Lambda Layer ARN you can use with Lambda runtimes based on Amazon Linux 2 (such
as the `nodejs10.x` runtime).

For an example of how to use the layer, check out 
<https://github.com/serverlesspub/pandoc-aws-lambda-binary/tree/master/example>
