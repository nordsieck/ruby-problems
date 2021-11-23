.PHONY: test
test:
	find . -name "test*.rb" | xargs -iX ruby X
