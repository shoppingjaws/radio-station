FROM yyoshiki41/radigo AS radigo
FROM alpine:3.14
COPY --from=radigo /bin/radigo /bin/radigo
RUN apk add --no-cache ca-certificates ffmpeg rtmpdump tzdata curl nodejs aws-cli jq
WORKDIR /
COPY bootstrap /
COPY function.sh /var/task/
COPY ./src/* /var/task/src/
RUN chmod +x /bootstrap /var/task/function.sh
ENV TZ "Asia/Tokyo"

ENTRYPOINT ["/bootstrap"]
CMD ["function.handler"]
