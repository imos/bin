readme:
	tool/update-readme
.PHONY: readme

update: readme
	tool/update
.PHONY: update

test:
	bash --version
	env
	bash -c shopt
	@if ! bash test/main.sh test/*_test.sh; then exit 1; fi
.PHONY: test
