#!/bin/bash

# Set the Tomcat manager credentials
TOMCAT_USER="admin"
TOMCAT_PASSWORD="admin"

# Set the application name and URL
APP_NAME="MoonPageWebApp"
APP_URL="http://3.111.43.66:8080/$APP_NAME/"

# Check if the application is running
APP_STATUS=$(curl --silent --user $TOMCAT_USER:$TOMCAT_PASSWORD "http://3.111.43.66:8000/manager/text/list" | grep -F "$APP_NAME:running")
if [ -n "$APP_STATUS" ]; then
  echo "Application $APP_NAME is running"
else
  echo "Application $APP_NAME is not running"
fi

# Check if the application is accessible
APP_RESPONSE=$(curl --write-out %{http_code} --silent --output /dev/null "$APP_URL")
if [ "$APP_RESPONSE" = "200" ]; then
  echo "Application $APP_NAME is accessible"
else
  echo "Application $APP_NAME is not accessible"
fi
