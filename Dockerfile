# Use official Tomcat base image (Java + Tomcat preinstalled)
FROM tomcat:9.0

# Remove the default Tomcat ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your Eclipse webapp (HTML, JSP, WEB-INF, etc.) into Tomcat ROOT
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Railway assigns a PORT dynamically, default Tomcat is 8080
# We'll map Railway's $PORT to Tomcat
ENV PORT 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
