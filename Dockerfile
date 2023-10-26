FROM golang:1-alpine as builder
ARG VERSION

RUN apk --no-cache add make jq curl

RUN mkdir -p /root/gocode
ENV GOPATH=/root/gocode 

WORKDIR $GOPATH/src/github.com/mailhog/MailHog
RUN curl -L https://github.com/mailhog/MailHog/archive/refs/tags/${VERSION}.tar.gz | tar -xz --strip-components=1 

ENV GO111MODULE="off"
ENV CGO_ENABLED=0
ENV GOOS=linux 
RUN go build -ldflags "-X main.version=$VERSION" -o $GOPATH/bin/MailHog


FROM alpine:3
# Add mailhog user/group with uid/gid 1000.
# This is a workaround for boot2docker issue #581, see
# https://github.com/boot2docker/boot2docker/issues/581
RUN adduser -D -u 1000 mailhog

COPY --from=builder /root/gocode/bin/MailHog /usr/local/bin/

USER mailhog

WORKDIR /home/mailhog

ENTRYPOINT ["MailHog"]

# Expose the SMTP and HTTP ports:
EXPOSE 1025 8025