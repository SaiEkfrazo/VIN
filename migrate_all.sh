#!/bin/bash

# List of service names
services=("django1" "django2" "django3" "django4" "django5" "django6" "django7" "django8" "django9" "django10")

# Loop through each service and run migrations
for service in "${services[@]}"
do
    echo "Migrating $service..."
    docker-compose exec $service sh -c 'python manage.py makemigrations && python manage.py migrate'
    echo "Migration for $service completed"
    echo "--------------------------------------"
done
