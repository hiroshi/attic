PROJECT := topics-server
IMAGE = us-west1-docker.pkg.dev/$(PROJECT)/attic/attic

PHONY: tag
tag:
	$(eval TAG=$(shell git rev-parse --short HEAD))
	@echo TAG=$(TAG)

docker-build: tag
	docker build --platform=linux/amd64 -t $(IMAGE):$(TAG)  ./

docker-push: tag
	docker push $(IMAGE):$(TAG)
	docker tag $(IMAGE):$(TAG) $(IMAGE):latest
	docker push $(IMAGE):latest

## GKE
KUBECTL := kubectl --cluster=gke_topics-server_us-west1-a_topics
deploy: sleep attic

# NOTE: maybe solve following error when deploying immediate after push
#   Failed to pull image "us-west1-docker.pkg.dev/topics-server/attic/attic:7895e77": rpc error: code = Unavailable desc = error reading from server: EOF
sleep:
	sleep 1

export TAG
attic: tag
	cat gke/attic.yaml | envsubst | $(KUBECTL) apply -f -
	$(KUBECTL) rollout status -w deployment/attic

# artifact registry
docker-repository:
	gcloud artifacts repositories create attic \
	  --project=$(PROJECT) \
	  --location=us-west1 \
	  --repository-format=docker

artifact-registry-cleanup-policy:
	gcloud artifacts repositories set-cleanup-policies attic \
	  --project=$(PROJECT) \
	  --location=us-west1 \
	  --policy=gke/artifact-registry-cleanup-policy.yml
