#!/bin/bash

#IMAGE="gcr.io/google-containers/ubuntu-slim:0.14"
IMAGE="gcr.io/google.com/cloudsdktool/google-cloud-cli:467.0.0"
COMMAND="/bin/bash"
NAMESPACE="default"
SUFFIX=$(date +%s | shasum | base64 | fold -w 10 | head -1 | tr '[:upper:]' '[:lower:]')

usage_exit() {
    echo "Usage: $0 [-c command] [-i image] PVC ..." 1>&2
    exit 1
}

while getopts i:n:c:h OPT
do
    case $OPT in
        i)  IMAGE=$OPTARG
            ;;
        c)  COMMAND=$OPTARG
            ;;
        n)  NAMESPACE=$OPTARG
            ;;
        h)  usage_exit
            ;;
        \?) usage_exit
            ;;
    esac
done
shift $((OPTIND - 1))

VOL_MOUNTS=""
VOLS=""
COMMA=""

for i in "$@"
do
  VOL_MOUNTS="${VOL_MOUNTS}${COMMA}{\"name\": \"${i}\",\"mountPath\": \"/pvcs/${i}\"}"
  VOLS="${VOLS}${COMMA}{\"name\": \"${i}\",\"persistentVolumeClaim\": {\"claimName\": \"${i}\"}}"
  COMMA=","
done

kubectl run -it --rm --namespace="$NAMESPACE" --restart=Never --image="$IMAGE" "pvc-mounter-${SUFFIX}" --overrides "
{
  \"spec\": {
    \"hostNetwork\": true,
    \"containers\":[
      {
        \"args\": [\"${COMMAND}\"],
        \"stdin\": true,
        \"tty\": true,
        \"name\": \"pvc\",
        \"image\": \"${IMAGE}\",
        \"volumeMounts\": [
          ${VOL_MOUNTS}
        ]
      }
    ],
    \"volumes\": [
      ${VOLS}
    ]
  }
}
" -- ${COMMAND}
