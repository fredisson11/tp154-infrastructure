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
	terraform init

plan: init
	terraform plan -var-file=$(TFVARS) -var-file=$(SECRET)

apply: init
	terraform apply -auto-approve -var-file=$(TFVARS) -var-file=$(SECRET)

destroy: init
	terraform destroy -auto-approve -var-file=$(TFVARS) -var-file=$(SECRET)

clean:
	@if [ -f backend.tf ]; then \
		rm backend.tf; \
		echo "🧹 Видалено тимчасовий backend.tf"; \
	fi