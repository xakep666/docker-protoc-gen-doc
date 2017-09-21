FROM alpine:latest as builder
# install build-tools
RUN apk add --no-cache git protobuf-dev make g++ qt5-qttools-dev
# clone and build
RUN mkdir /src && cd /src && \
	git clone https://github.com/pseudomuto/protoc-gen-doc.git && cd protoc-gen-doc && \
	/usr/lib/qt5/bin/qmake && make

FROM alpine:latest
# install dependencies
RUN apk add --no-cache protobuf qt5-qtbase
# add binary
COPY --from=builder /src/protoc-gen-doc/protoc-gen-doc /usr/bin

