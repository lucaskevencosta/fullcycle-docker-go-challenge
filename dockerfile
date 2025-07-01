FROM golang:1.20-alpine AS builder

RUN apk add --no-cache git
WORKDIR /app
COPY . .
RUN go mod init full-cycle-rocks && go mod tidy
RUN go build -o full-cycle-rocks

FROM scratch
WORKDIR /
COPY --from=builder /app/full-cycle-rocks .
EXPOSE 8080
CMD ["./full-cycle-rocks"]