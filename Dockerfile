# Stage 1: Builder

FROM golang:alpine AS builder
WORKDIR /app
COPY ./app/* .
RUN go build -o main

# Stage 2: Final Image

FROM alpine:3.19
# hadolint ignore=DL3018
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=builder /app/main /app/
EXPOSE 8080 
ENTRYPOINT ["/app/main"]