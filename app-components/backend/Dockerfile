
FROM eclipse-temurin:17-jdk-jammy AS build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN --mount=type=cache,target=/root/.m2 LD_LIBRARY_PATH="." ./mvnw -f $HOME/pom.xml clean package  -Dmaven.test.skip

#
# Package stage
#
FROM eclipse-temurin:17-jre-jammy 
ARG JAR_FILE=/usr/app/target/*.jar

# Incluindo a variável de ambiente $NAME
ENV NAME=$NAME

# Add the built jars from previous stage
COPY --from=build $JAR_FILE /app/runner.jar

EXPOSE 3000

# Define the path for the dynamic libraries from SAP JCO (native)
ENV LD_LIBRARY_PATH="/app"

WORKDIR /app
ENTRYPOINT ["sh", "-c", "LD_LIBRARY_PATH='.' java -jar runner.jar"]