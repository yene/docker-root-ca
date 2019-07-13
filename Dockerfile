
# do not increase go version without testing it
FROM golang:1.12.4 as build-env

WORKDIR /go/src/app
COPY . /go/src/app
RUN go get -d -v ./...
RUN go install -v ./...

# Adding our root CA to the distorless certificates
COPY --from=gcr.io/distroless/base:latest /etc/ssl/certs/ca-certificates.crt /ca-certificates.crt

COPY ms-v1.pem /ms-v1.pem
RUN cat /ms-v1.pem >> /ca-certificates.crt

COPY ms-v2.pem /ms-v2.pem
RUN cat /ms-v2.pem >> /ca-certificates.crt

FROM gcr.io/distroless/base:latest
ENV PORT 3002
COPY --from=build-env /go/bin/app /
COPY --from=build-env /ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
CMD ["/app"]
