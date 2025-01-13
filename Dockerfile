#FROM openjdk:21-jdk-slim
#COPY target/*.jar app.jar
#EXPOSE 8090
#ENTRYPOINT ["java","-jar","/app.jar"]

#FROM maven:3.9.9-eclipse-temurin-21 AS build
#WORKDIR /home/app
#COPY . /home/app
#RUN mvn -f /home/app/pom.xml clean package
#
#FROM openjdk:21-jdk-slim
#EXPOSE 8090
#COPY  --from=build /home/app/target/*.jar app.jar
#ENTRYPOINT ["sh", "-c", "java -jar /app.jar"]


FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /home/app

COPY ./pom.xml /home/app/pom.xml
COPY ./src/main/java/com/springframework/microservices/helloworldjava/HelloWorldJavaApplication.java /home/app/src/main/java/com/springframework/microservices/helloworldjava/HelloWorldJavaApplication.java

RUN mvn -f /home/app/pom.xml clean package

COPY . /home/app
RUN mvn -f /home/app/pom.xml clean package

FROM openjdk:21-jdk-slim
EXPOSE 8090
COPY  --from=build /home/app/target/*.jar app.jar
ENTRYPOINT ["sh", "-c", "java -jar /app.jar"]