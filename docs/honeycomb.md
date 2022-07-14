## How to execute honeycomb from a docker, init, plan, apply, destroy

### Cd intro each case as instance
```shell
cd provider/honeycomb/board
```

### Init:
```shell
docker run -i -t -v $PWD:$PWD -w $PWD \
-e HONEYCOMBIO_APIKEY=$HONEYCOMBIO_APIKEY \
hashicorp/terraform:light \
init -reconfigure \
-backend-config="resource_group_name=tf-state-rg" \
-backend-config="storage_account_name=tf-storage" \
-backend-config="container_name=tfstate" \
-backend-config="key=terraform.tfstate"
```

### Plan:
```shell
docker run -i -t -v $PWD:$PWD -w $PWD \
-e HONEYCOMBIO_APIKEY=$HONEYCOMBIO_APIKEY \
hashicorp/terraform:light \
plan -out=$PLAN_FILE
```

### Apply:
```shell
docker run -i -t -v $PWD:$PWD -w $PWD \
-e HONEYCOMBIO_APIKEY=$HONEYCOMBIO_APIKEY \
hashicorp/terraform:light \
apply $PLAN_FILE
```

### Destroy:
```shell
docker run -i -t -v $PWD:$PWD -w $PWD \
-e HONEYCOMBIO_APIKEY=$HONEYCOMBIO_APIKEY \
hashicorp/terraform:light \
destroy -auto-approve
```