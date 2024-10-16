BINARY_NAME=kc
VERSION=0.1.0
BUILD_TIME=$(shell date +%FT%T%z)
LDFLAGS=-ldflags "-X main.Version=${VERSION} -X main.BuildTime=${BUILD_TIME}"

.PHONY: build clean test install

build:
	go build ${LDFLAGS} -o bin/${BINARY_NAME}

clean:
	rm -rf bin/

test:
	go test -v ./...

install: build
	mv bin/${BINARY_NAME} /usr/local/bin/

# Homebrew formula
formula:
	mkdir -p Formula
	sed "s/VERSION/${VERSION}/g" scripts/formula.rb.template > Formula/kubeclick.rb

# Package for different platforms
package:
	GOOS=darwin GOARCH=amd64 go build ${LDFLAGS} -o bin/${BINARY_NAME}-darwin-amd64
	GOOS=darwin GOARCH=arm64 go build ${LDFLAGS} -o bin/${BINARY_NAME}-darwin-arm64
	GOOS=linux GOARCH=amd64 go build ${LDFLAGS} -o bin/${BINARY_NAME}-linux-amd64
	GOOS=windows GOARCH=amd64 go build ${LDFLAGS} -o bin/${BINARY_NAME}-windows-amd64.exe
