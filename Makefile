NAME=terraform
VERSION=0.12.25
TERRAFORM_VERSION=$(VERSION)
REVISION=1
MAINT=james.earl.3@gmail.com
DESCRIPTION="HashiCorp's Terraform v$(TERRAFORM_VERSION)"

DEB=$(NAME)_$(VERSION)-$(REVISION)
DEB_64=$(DEB)_amd64.deb
SRC_64=https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_linux_amd64.zip

.PHONY: dev build publish-gemfury ls uninstall install clean

dev: clean build

build: dist/$(DEB_64)

publish-gemfury:
	fury push dist/$(DEB_64) --public

ls:
	gemfury versions "$(NAME)"

bin/:
	mkdir -p ./bin

dist/:
	mkdir -p ./dist

bin/terraform_$(TERRAFORM_VERSION)_linux_amd64: bin/
	wget -nc -nv -O - $(SRC_64) | gunzip >bin/terraform_$(TERRAFORM_VERSION)_linux_amd64
	chmod +x bin/terraform_$(TERRAFORM_VERSION)_linux_amd64

dist/$(DEB_64): dist/ bin/terraform_$(TERRAFORM_VERSION)_linux_amd64
	fpm -s dir \
		--description $(DESCRIPTION) \
		-t deb \
		-p dist/$(DEB_64) \
		-n $(NAME) \
		--provides $(NAME) \
		-v $(VERSION) \
		--iteration $(REVISION) \
		-a amd64 \
		-m $(MAINT) \
		--deb-no-default-config-files \
		bin/terraform_$(TERRAFORM_VERSION)_linux_amd64=/usr/bin/terraform

clean:
	rm -rf dist/*

uninstall:
	apt remove -y $(NAME) || true

install:
	apt install -y --reinstall --allow-downgrades ./dist/$(DEB_64)
