FROM openjdk:8
EXPOSE 8080
ADD target/sampledemo1.jar sampledemo1.jar
ENTRYPOINT ["java","-jar","/sampledemo1.jar"]