
# Build stage
FROM openjdk:25-jdk-slim AS build

WORKDIR /app

# Copy Maven wrapper
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

# Make Maven wrapper executable
RUN chmod +x ./mvnw

# Build the application
RUN ./mvnw clean package -DskipTests

# Runtime stage
FROM openjdk:25-jdk-slim
WORKDIR /app

# Copy the built JAR
COPY --from=build /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "/app.jar"]