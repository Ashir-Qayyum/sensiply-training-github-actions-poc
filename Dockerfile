FROM maven:3.8.5-openjdk-11 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

# adding flags to skip the frontend-maven-plugin and tests
# This ensures Maven ONLY builds the Java code.
RUN mvn clean package -DskipTests -Dskip.installnodenpm -Dskip.npm




FROM eclipse-temurin:11-jre

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]