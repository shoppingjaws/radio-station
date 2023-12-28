ACCOUNT_ID=`aws sts get-caller-identity --query Account --output text`


aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com
docker build -t radio_station_scheduled_task_ecr .
docker tag radio_station_scheduled_task_ecr:latest ${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com/radio_station_scheduled_task_ecr:latest
docker push ${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com/radio_station_scheduled_task_ecr:latest
