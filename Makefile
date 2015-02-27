TAGS = 5.3-apache

.PHONY: $(TAGS)

all: $(TAGS)
	
$(TAGS):
	cd $@ && docker build -t dehy/php:$@ .
