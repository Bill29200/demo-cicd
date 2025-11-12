# Étape de construction
FROM openjdk:25-jdk-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src src
COPY mvnw .
COPY .mvn .mvn
RUN chmod +x ./mvnw
RUN ./mvnw clean package -DskipTests

# Étape d'exécution
FROM openjdk:25-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]

# Start the application
ENTRYPOINT ["java", "-jar", "/app.jar"]