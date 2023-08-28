FROM maven:3.8.3-jdk-11-slim AS build

RUN mkdir /project

COPY . /project

WORKDIR /project

RUN mvn clean package

FROM adoptopenjdk/openjdk11:jre-11.0.19_7-alpine

RUN mkdir /app

COPY --from=build /project/target/app.war /app/app.war

ENV SPRING_PROFILE=stg

WORKDIR /app

EXPOSE 8080

CMD ["java", "$JAVA_OPTS", "-jar app.war", "-Dspring.profiles.active=$SPRING_PROFILE"]
