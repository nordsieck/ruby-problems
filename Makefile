.PHONY: test
test:
	find . -name "test*.rb" | xargs ruby
