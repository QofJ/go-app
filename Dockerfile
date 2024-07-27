# Dockerfile
FROM golang:1.16-alpine

WORKDIR /app

COPY . .

RUN go mod init demo

RUN go build -o main .

EXPOSE 8080

CMD ["./main"]
