FROM maven:3.8.6-jdk-11-slim AS build

RUN mkdir /project

COPY . /project

WORKDIR /project

RUN mvn clean package

FROM adoptopenjdk/openjdk11:jre-11.0.19_7-alpine

RUN mkdir /app

COPY --from=build /project/target/app.war /app/app.war

ENV PROFILE=dev

WORKDIR /app

EXPOSE 8080

# ENTRYPOINT ["java", "-Dspring.profiles.active=${PROFILE}",  "-jar", "app.war"]
# ENTRYPOINT java -Dspring.profiles.active=${PROFILE} -jar app.war
ENTRYPOINT ["java", "-Dspring.profiles.active=${PROFILE}", "-jar", "app.war"]
