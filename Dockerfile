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


FROM scratch
USER 10001

ENTRYPOINT ["MailHog"]

# Expose the SMTP and HTTP ports:
EXPOSE 1025 8025

COPY --from=builder /root/gocode/bin/MailHog /usr/local/bin/