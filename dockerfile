# Étape de construction
FROM openjdk:25-jdk-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src src
COPY mvnw .
COPY .mvn .mvn
RUN chmod +x ./mvnw
RUN ./mvnw clean package -DskipTests

# Étape de création de l'image finale
FROM openjdk:25-jdk-slim
VOLUME /tmp
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]