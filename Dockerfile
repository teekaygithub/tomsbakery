#
# BUILD STAGE
#
FROM maven:3.8.4-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN ["mvn", "-f", "/home/app/pom.xml", "clean", "install"]

#
# PACKAGE STAGE
#
FROM openjdk:18-jdk-alpine3.15
COPY --from=build /home/app/target/tomsbakery-1.0-SNAPSHOT.jar /usr/local/lib/app.jar
ENTRYPOINT ["java", "-jar", "/usr/local/lib/app.jar"]