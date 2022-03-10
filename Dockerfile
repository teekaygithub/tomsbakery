# FROM maven:3.8.4-jdk-11-slim AS build
# WORKDIR /usr/app
# COPY pom.xml ./
# RUN ["mvn", "dependency:go-offline"]

# COPY src ./src
# ENV SQL_HOST=${SQL_HOST}tomsbakery
# ENV SQK_TK_USER=${SQL_TK_USER}
# ENV SQL_TK_PW=${SQL_TK_PW}
# RUN ["mvn", "-f", "./pom.xml", "install", "-Dmaven.test.skip=true"]

# FROM openjdk:18-jdk-alpine3.15
# COPY --from=build /usr/app/target/tomsbakery-1.0-SNAPSHOT.jar /usr/local/lib/app.jar
# ENTRYPOINT ["java", "-jar", "/usr/local/lib/app.jar"]

FROM openjdk:18-jdk-alpine3.15
ADD target/tomsbakery-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]