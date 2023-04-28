# Use the official Tomcat image as the base image
FROM tomcat:latest

# Copy the .war file from the Jenkins workspace to the Tomcat webapps folder
COPY target/*.war /usr/local/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8090

# Start Tomcat
CMD ["catalina.sh", "run"]
