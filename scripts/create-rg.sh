NAME=$1
LOCATION=$2


FILE_PATH=infra/${NAME}-rg.yaml

cp crossplane/rg-template.yaml $FILE_PATH
yq --inplace ".metadata.name = \"${NAME}\"" $FILE_PATH
yq --inplace ".spec.forProvider.location = \"${LOCATION}\"" $FILE_PATH
