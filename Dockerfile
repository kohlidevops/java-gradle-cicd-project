FROM openjdk:11 as base 
WORKDIR /app
COPY . . 
RUN chmod +x gradlew
RUN ./gradlew build 

FROM tomcat:9
WORKDIR webapps
COPY --from=base /app/build/libs/myapp.war .
RUN rm -rf ROOT && mv myapp.war ROOT.war 
EXPOSE 8080
CMD ["catalina.sh", "run"]
