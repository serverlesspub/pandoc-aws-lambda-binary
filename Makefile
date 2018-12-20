DEPLOYMENT_BUCKET_NAME := claudia-layers
DEPLOYMENT_KEY := $(shell echo pandoc-$$RANDOM.zip)
STACK_NAME := pandoc-lambda-layer

clean: 
	rm -rf build

build/bin/pandoc: vendor/pandoc.gz
	mkdir -p build/bin
	cp vendor/pandoc.gz build/bin
	gzip -d build/bin/pandoc.gz

build/layer.zip: build/bin/pandoc
	cd build && zip -r layer.zip bin

# cloudformation has no support for packaging layers yet, so need to do this manually
#
build/output.yml: build/layer.zip cloudformation/template.yml
	aws s3 cp build/layer.zip s3://$(DEPLOYMENT_BUCKET_NAME)/$(DEPLOYMENT_KEY)
	sed "s:DEPLOYMENT_BUCKET_NAME:$(DEPLOYMENT_BUCKET_NAME):;s:DEPLOYMENT_KEY:$(DEPLOYMENT_KEY):" cloudformation/template.yml > build/output.yml

deploy: build/output.yml
	aws cloudformation deploy --template-file build/output.yml --stack-name $(STACK_NAME)
	aws cloudformation describe-stacks --stack-name $(STACK_NAME) --query Stacks[].Outputs[].OutputValue --output text

