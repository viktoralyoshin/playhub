SERVICES = api-gateway auth-service rating-service social-service

.PHONY: get getutils

get:
	@for service in $(SERVICES); do \
		echo "Updating dependencies in $$service..."; \
		cd $$service && go get -u github.com/viktoralyoshin/playhub-proto@v1.1.27 && cd ..; \
	done

getutils:
	@for service in $(SERVICES); do \
		echo "Updating dependencies in $$service..."; \
		cd $$service && go get -u github.com/viktoralyoshin/utils@v1.4.0 && cd ..; \
	done

tidy:
	@for service in $(SERVICES); do \
		echo "Updating dependencies in $$service..."; \
		cd $$service && go mod tidy && cd ..; \
	done