FROM gcr.io/distroless/base-debian10

WORKDIR /

ENV PORT=8080

EXPOSE 8080

COPY ./build/app /app

USER nonroot:nonroot

ENTRYPOINT ["/app"]
