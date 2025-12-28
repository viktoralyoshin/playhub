SERVICES = api-gateway auth-service rating-service social-service
PROTO_VERSION = v1.1.27
UTILS_VERSION = v1.4.0

.PHONY: get getutils tidy all-updates

get:
	@for service in $(SERVICES); do \
		echo "Updating proto in $$service..."; \
		cd $$service && go get -u github.com/viktoralyoshin/playhub-proto@$(PROTO_VERSION) && cd ..; \
	done

getutils:
	@for service in $(SERVICES); do \
		echo "🛠 Updating utils in $$service..."; \
		cd $$service && go get -u github.com/viktoralyoshin/utils@$(UTILS_VERSION) && cd ..; \
	done

tidy:
	@for service in $(SERVICES); do \
		echo "Tidy in $$service..."; \
		cd $$service && go mod tidy && cd ..; \
	done

all-updates: get getutils tidy
	@echo "All services updated successfully"