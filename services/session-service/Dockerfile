FROM openjdk:8-jdk-alpine as builder

WORKDIR /build

RUN apk update && apk upgrade

COPY pom.xml mvnw ./
COPY .mvn/ .mvn/
RUN ./mvnw dependency:go-offline

COPY . .
RUN ./mvnw package -DskipTests


FROM openjdk:8-jre-alpine

WORKDIR /app

COPY --from=builder /build/target/*.jar app.jar

CMD [ "java", "-jar", "app.jar" ]
