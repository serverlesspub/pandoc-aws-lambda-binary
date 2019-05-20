# Pandoc for AWS Lambda

Scripts to compile Pandoc for AWS Lambda instances powered by Amazon Linux 2.x, such as the `nodejs10.x` runtime, and the updated 2018.03 Amazon Linux 1 runtimes. 

## Usage

Absolutely the easiest way of using this is to pull it directly from the AWS Serverless Application repository into a CloudFormation/SAM application, or deploy directly from the Serverless Application Repository into your account, and then link as a layer. 

The `pandoc` binary will be in `/opt/bin/pandoc` after linking the layer to a Lambda function.

For more information, check out the [pandoc-lambda-layer](https://console.aws.amazon.com/serverlessrepo/home?region=us-east-1#/published-applications/arn:aws:serverlessrepo:us-east-1:145266761615:applications~pandoc-lambda-layer) application in the Serverless App Repository.

For manual deployments and custom builds, read below...

## Prerequisites

* Docker desktop
* Unix Make environment
* AWS command line utilities (just for deployment)

## Compiling the code

* start Docker services
* `make all`

There are two `make` scripts in this project.

* [`Makefile`](Makefile) is intended to run on the build system, and just starts a Docker container matching the AWS Linux 2 environment for Lambda runtimes to compile Pandoc using the second script.
* [`Makefile_Pandoc`](Makefile_Pandoc) is the script that will run inside the container, and actually compile binaries. 

The output will be in the `result` dir.

### Configuring the build

By default, this compiles a version expecting to run as a Lambda layer from `/opt`. You can change the expected location by providing a `TARGET` variable when invoking `make`.

The default Docker image used is `lambci/lambda-base-2:build`. To use a different base, provide a `DOCKER_IMAGE` variable when invoking `make`.

Modify the versions of libraries or Pandoc directly in [`Makefile_Pandoc`](Makefile_Pandoc).

### Experimenting

* `make bash` to open an interactive shell with all the build directories mounted

### Compiled info

```
pandoc 2.7.2
Compiled with pandoc-types 1.17.5.4, texmath 0.11.2.2, skylighting 0.7.7
```

## Deploying to AWS as a layer

Run the following command to deploy the compiled result as a layer in your AWS account.

```
make deploy DEPLOYMENT_BUCKET=<YOUR BUCKET NAME>
```

### configuring the deployment

By default, this uses `pandoc-layer` as the stack name. Provide a `STACK_NAME` variable when
calling `make deploy` to use an alternative name.

### example usage

An example project is in the [example](example) directory. It sets up two buckets, and listens to file uploads on the first bucket to convert and generate HTML files from markdown. You can deploy it from the root Makefile using:

```
make deploy-example DEPLOYMENT_BUCKET=<YOUR BUCKET NAME>
```

For more information, check out:

* https://pandoc.org/installing.html

## Author

Gojko Adzic <https://gojko.net>

## License

* These scripts: [MIT](https://opensource.org/licenses/MIT)
* Pandoc: https://github.com/jgm/pandoc/blob/master/COPYRIGHT
* Contained libraries all have separate licenses, check the respective web sites for more information
