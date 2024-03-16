FROM openjdk:8-jre-slim
WORKDIR /app
COPY target/simpleapp-0.0.1-SNAPSHOT.jar /app/simpleapp-0.0.1-SNAPSHOT.jar
EXPOSE 8080
CMD ["java", "-jar", "simpleapp-0.0.1-SNAPSHOT.jar"]