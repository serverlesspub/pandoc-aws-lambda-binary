PROJECT_ROOT = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

DOCKER_IMAGE ?= lambci/lambda-base-2:build
TARGET ?=/opt/

MOUNTS = -v $(PROJECT_ROOT):/var/task \
	-v $(PROJECT_ROOT)result:$(TARGET) \
	-v $(PROJECT_ROOT)cache:/usr/local

DOCKER = docker run -it --rm -w=/var/task/build
build result cache: 
	mkdir $@

clean:
	rm -rf build result cache

test:
	$(DOCKER) $(MOUNTS) --entrypoint /opt/bin/pandoc -t $(DOCKER_IMAGE) -v

bash:
	$(DOCKER) $(MOUNTS) --entrypoint /bin/bash -t $(DOCKER_IMAGE)

all: build result cache 
	$(DOCKER) $(MOUNTS) --entrypoint /usr/bin/make -t $(DOCKER_IMAGE) TARGET_DIR=$(TARGET) -f ../Makefile_Pandoc $@


STACK_NAME ?= pandoc-layer 

#result/bin/pandoc: all

build/output.yaml: template.yaml result/bin/pandoc
	aws cloudformation package --template $< --s3-bucket $(DEPLOYMENT_BUCKET) --output-template-file $@

deploy: build/output.yaml
	aws cloudformation deploy --template $< --stack-name $(STACK_NAME)
	aws cloudformation describe-stacks --stack-name $(STACK_NAME) --query Stacks[].Outputs --output table

deploy-example:
	cd example && \
		make deploy DEPLOYMENT_BUCKET=$(DEPLOYMENT_BUCKET) PANDOC_STACK_NAME=$(STACK_NAME)
