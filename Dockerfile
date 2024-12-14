FROM golang:1.18-alpine AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY main.go ./

RUN go build -ldflags="-s -w" -o fullcycle .

# Final stage
FROM scratch
WORKDIR /app
COPY --from=builder /app/fullcycle .
CMD ["./fullcycle"]

################################################################
#
# link da imagem publicada no docker-hub: carlosmorais/fullcycle
#
################################################################
