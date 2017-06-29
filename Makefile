SHELL:=/bin/bash
SHELL += -eu

.BLUE := \033[0;34m
.GREEN := \033[0;32m
.OK :=${.GREEN}✓
.RED := \033[0;31m
.NC := \033[0m

.T=/tmp
ifeq ($(OS), Windows_NT)
.T:=../../..
endif
.PLANFILE=$(.T)/plan_website_example

all: plan
help:
	@echo -e "${.BLUE}Usage: make plan"
	@echo -e "After applying terraform plan it prompt if to apply the changes."
	@echo -e "Other commands: "
	@echo -e " * make show - to list what the plan will apply "
	@echo -e " * make clean - delete the executed plan, so no files left behind "
	@echo -e " * make format - execute terraform fmt${.NC}"
clean:
	@echo -e "${.BLUE} clean up state file used${.NC}"
	@rm -f ${.PLANFILE}
	@echo -e "${.OK} deleted${.NC}"
plan: .format get
	@echo -e "${.BLUE}Checking Infrastracture${.NC}"
	@terraform plan -parallelism=80 -refresh=true -module-depth=-1 -out ${.PLANFILE}
	$(MAKE) .confirm
	$(MAKE) apply
show:
	@echo -e "${.BLUE}Showing plan to apply"
	@echo -e "${.OK} Plan is stored: ${.PLANFILE}${.NC}"
	@terraform show ${.PLANFILE}
.format:
	@echo -e "${.BLUE}Format existing code${.NC}"
	@terraform fmt
	@echo -e "${.OK} code formated${.NC}"
apply:
	@echo -e "${.BLUE}Applying changes to Infrastracture${.NC}"
	@terraform apply -parallelism=80 ${.PLANFILE}
	@echo -e "${.OK} terraform completed${.NC}"
	$(MAKE) clean
.confirm:
	@echo -e "Type ${.BLUE}y${.NC} to apply, otherwise it will abort ${.RED}(timeout in 35 seconds)${.NC}"
	@read -r -t 5 -p "->" CONTINUE; \
	if [ ! $$CONTINUE == "y" ] || [ -z $$CONTINUE ]; then \
	    echo -e "${.RED}Abort apply.${.NC}" ; \
		exit 1; \
	fi
