FROM golang:1.20.4-alpine3.18 AS BuildStage


RUN go install github.com/googlecodelabs/tools/claat@latest

FROM alpine:latest
WORKDIR /app
COPY . .

COPY --from=BuildStage /go/bin/claat /usr/local/bin/claat

RUN apk add --update npm

WORKDIR /app/site
RUN npm install 

EXPOSE 8000
CMD ["npm", "run", "prod"]
