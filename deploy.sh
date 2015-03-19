# deploy.sh
#! /bin/bash

SHA1=$1
BRANCH=$2

case $BRANCH in
  master)
    ENVIRONMENT_NAME=hello-env
    ;;
  staging)
    ENVIRONMENT_NAME=hello-staging
    ;;
  production)
    ENVIRONMENT_NAME=hello-production
    ;;
esac

# Deploy image to Docker Hub
sudo docker push shapeshed/node-hello:$SHA2

# Create new Elastic Beanstalk version
EB_BUCKET=pebbledocker
DOCKERRUN_FILE=$SHA1-Dockerrun.aws.json
sed "s/<TAG>/$SHA1/" < Dockerrun.aws.json.template > $DOCKERRUN_FILE
aws s3 cp $DOCKERRUN_FILE s3://$EB_BUCKET/$DOCKERRUN_FILE
aws elasticbeanstalk create-application-version --application-name hello \
    --version-label $SHA1 --source-bundle S3Bucket=$EB_BUCKET,S3Key=$DOCKERRUN_FILE

# Update Elastic Beanstalk environment to new version
aws elasticbeanstalk update-environment --environment-name $ENVIRONMENT_NAME \
      --version-label $SHA1
