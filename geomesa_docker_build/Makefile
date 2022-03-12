current_branch := 0.1
name := lawlite19/geomesa-hbase_2.12-3.3.0

.PHONY: build start push

build:
	docker build -t $(name):$(current_branch) .

tag-latest:
	docker tag $(name):$(current_branch) ${name}:latest

serve:
	docker run -it --rm $(name):$(current_branch) /bin/bash

push: build tag-latest
	docker push $(name):$(current_branch); docker push $(name):latest
