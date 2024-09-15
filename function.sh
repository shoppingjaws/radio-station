function handler() {
    EVENT_DATA=$1
    echo "${EVENT_DATA}" 1>&2
    RESPONSE="Echoing request: '${EVENT_DATA}'"
    node ${LAMBDA_TASK_ROOT}/src/parse_args.js $EVENT_DATA 1>&2
    export REC_ARGS=$(node "${LAMBDA_TASK_ROOT}"/src/parse_args.js "$EVENT_DATA")
    export RADIGO_HOME="/tmp/output/"
    export RADIKO_MAIL=$(aws ssm get-parameter --name /radio-station/email --query "Parameter.Value" --with-decryption --output text)
    export RADIKO_PASSWORD=$(aws ssm get-parameter --name /radio-station/password --query "Parameter.Value" --with-decryption --output text)
    /bin/radigo rec $REC_ARGS 1>&2
    export FILE_NAME=$(ls /tmp/output)
    export ID=$(echo $EVENT_DATA | jq -r ".id")
    aws s3 cp /tmp/output/$FILE_NAME s3://$BUCKET_NAME/$ID/ 1>&2
    #  update index.rss
    aws s3 ls s3://$BUCKET_NAME/$ID/ | sort -nr | grep -v .rss > /tmp/playlist.txt
    cat /tmp/playlist.txt 1>&2
    export TITLE=$(echo $EVENT_DATA | jq -r ".title")
    export IMAGE=$(echo $EVENT_DATA | jq -r ".image")
    node ${LAMBDA_TASK_ROOT}/src/gen_feed.js > /tmp/index.rss
    cat /tmp/index.rss 1>&2
    aws s3 cp /tmp/index.rss s3://$BUCKET_NAME/$ID/
    echo $RESPONSE
}