FROM yyoshiki41/radigo AS radigo
FROM alpine:latest
COPY --from=radigo /bin/radigo /bin/radigo
ENV TZ "Asia/Tokyo"
# Set default output dir
VOLUME ["/output"]

RUN apk add --no-cache ca-certificates ffmpeg rtmpdump tzdata
ENTRYPOINT ["/bin/radigo"]
CMD ["--help"]
