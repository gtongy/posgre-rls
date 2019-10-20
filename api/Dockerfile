FROM golang:1.13
WORKDIR /go/api
ENV GO111MODULE=on
COPY . .
RUN go get github.com/pilu/fresh
CMD ["fresh"]