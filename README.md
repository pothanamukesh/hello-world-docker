# Dockerfile Examples

## Docker commands
- docker build -t in28min/hello-world-docker:v1 .


## Dockerfile - 1 - Creating Docker Images

```
FROM openjdk:21-slim
COPY target/*.jar app.jar
EXPOSE 8090
ENTRYPOINT ["java","-jar","/app.jar"]
```

## Dockerfile - 2 - Build Jar File - Multi Stage
```
FROM maven:3.9.9-eclipse-temurin-21  AS build
WORKDIR /home/app
COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:21-slim
EXPOSE 8090
COPY --from=build /home/app/target/*.jar app.jar
ENTRYPOINT [ "sh", "-c", "java -jar /app.jar" ]

```

## Dockerfile - 3 - Caching

```
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /home/app

COPY ./pom.xml /home/app/pom.xml
COPY ./src/main/java/com/springframework/microservices/helloworldjava/HelloWorldJavaApplication.java /home/app/src/main/java/com/springframework/microservices/helloworldjava/HelloWorldJavaApplication.java

RUN mvn -f /home/app/pom.xml clean package

COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:21-slim
EXPOSE 8090
COPY --from=build /home/app/target/*.jar app.jar
ENTRYPOINT [ "sh", "-c", "java -jar /app.jar" ]
```