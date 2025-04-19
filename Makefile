ENV ?= development
TFVARS = envs/$(ENV)/terraform.tfvars
SECRET = envs/$(ENV)/secret.auto.tfvars
BACKEND = envs/$(ENV)/backend.tf

.PHONY: init plan apply destroy clean

init:
	@if [ -f $(BACKEND) ]; then \
		cp $(BACKEND) backend.tf; \
		echo "ℹ️ Підключено backend.tf з $(ENV)"; \
	fi
	terraform init -reconfigure

plan: init
	terraform plan -var-file=$(TFVARS) -var-file=$(SECRET)
	rm backend.tf

apply: init
	terraform apply -auto-approve -var-file=$(TFVARS) -var-file=$(SECRET)
	rm backend.tf

refresh: init
	terraform refresh -var-file=$(TFVARS) -var-file=$(SECRET)
	rm backend.tf

destroy: init
	terraform destroy -auto-approve -var-file=$(TFVARS) -var-file=$(SECRET)
	rm backend.tf

clean:
	@if [ -f backend.tf ]; then \
		rm backend.tf; \
	fi