STACK_NAME ?= pandoc-layer-example
PANDOC_STACK_NAME ?= pandoc-layer

PANDOC_LAYER ?=$(shell aws cloudformation describe-stacks --stack-name $(PANDOC_STACK_NAME) --query Stacks[].Outputs[].OutputValue --output text)
SOURCES=$(shell find src/)

clean: 
	rm -rf build

output.yaml: template.yaml $(SOURCES)
	mkdir -p build
	aws cloudformation package --template-file $< --output-template-file $@ --s3-bucket $(DEPLOYMENT_BUCKET)

deploy: output.yaml
	aws cloudformation deploy --template-file $< --stack-name $(STACK_NAME) --capabilities CAPABILITY_IAM --parameter-overrides PandocLayer=$(PANDOC_LAYER)
	aws cloudformation describe-stacks --stack-name $(STACK_NAME) --query Stacks[].Outputs --output table

