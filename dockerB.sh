#!/bin/bash
shopt -s expand_aliases
if [[ -z $1 ]]; then
        echo -e '\e[31mYou must specifiy image suffix as $namespace/$app:v$version \e[39m'
        exit
fi
NAME=$1
IMAGE=docker-registry.aeg.cloud/${NAME}
echo -e "\e[38;5;42m| Bulding docker | ${IMAGE}\e[39m"
dockerBuildOutput=$(docker build -t="${IMAGE}" . 2>&1)
echo $dockerBuildOutput
if [[ $dockerBuildOutput == *_"Successfully tagged"_* ]];
then
        echo -e '\e[31mYou must specifiy image suffix as $namespace/$app:v$version \e[39m'
        exit
fi
echo -e "\e[38;5;42m| Pushing docker | ${IMAGE}\e[39m"
docker push ${IMAGE}
echo -e "\e[38;5;42m| Pushing 2 prod | ${IMAGE}\e[39m"
URL="https://image-promoter.aeg.cloud/promote"
BODY="{ \"sourceImage\": \"${IMAGE}\", \"targetImage\": \"dfwdtrpr-awsw01.ds.dtvops.net/${NAME}\"}"
HDR="content-type: application/json"
#echo ${BODY}
curl -v -X POST -H "${HDR}" "${URL}" -d "${BODY}"