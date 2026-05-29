# 1. 빌드 단계
FROM gradle:8.14.3-jdk24 AS builder

WORKDIR /app

COPY build.gradle.kts settings.gradle.kts ./
RUN gradle dependencies --no-daemon || true

COPY src ./src

RUN gradle build --no-daemon -x test

# 2. 실행 단계
FROM eclipse-temurin:24-jdk

WORKDIR /app

COPY --from=builder /app/build/libs/demo-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]