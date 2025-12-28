#!/bin/bash
GITHUB_USER_1="viktoralyoshin"
GITHUB_USER_2="ddashadyy"
SERVICES_1=("api-gateway" "auth-service" "social-service" "rating-service")
SERVICES_2=("game-service" "library-service")

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}▶ Starting PlayHub Installation...${NC}"

echo -e "${BLUE}▶ Cloning microservices...${NC}"
for service in "${SERVICES_1[@]}"; do
    if [ -d "$service" ]; then
        echo -e "Service $service already exists, skipping clone..."
    else
        git clone "https://github.com/$GITHUB_USER_1/$service.git"
    fi
done

for service in "${SERVICES_2[@]}"; do
    if [ -d "$service" ]; then
        echo -e "Service $service already exists, skipping clone..."
    else
        git clone "https://github.com/$GITHUB_USER_2/$service.git"
        cd $service/ && mkdir third_party && cd third_party
        git clone "https://github.com/$GITHUB_USER_1/playhub-proto.git"
        cd ../../
    fi
done

echo -e "${BLUE}▶ Running Makefile...${NC}"
make all-updates

echo -e "${GREEN}Installation Complete! All services are ready"