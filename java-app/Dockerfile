FROM maven:3.8-jdk-11-slim AS build

COPY . /app
WORKDIR /app
# Définir le répertoire de travail dans le conteneurWORKDIR /app
RUN mvn install -DskipTests

FROM public.ecr.aws/lambda/java:11

RUN yum update -y && \
    yum install -y \
    awscli \
    wget \
    grep \
    sed \
    ksh \
    mutt

COPY --from=build /app/target/classes ${LAMBDA_TASK_ROOT}
COPY --from=build /app/target/dependency/* ${LAMBDA_TASK_ROOT}/lib/
# Copy function code and runtime dependencies from Maven layout
#COPY target/classes ${LAMBDA_TASK_ROOT}
#COPY target/dependency/* ${LAMBDA_TASK_ROOT}/lib/

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "de.rieckpil.blog.Java15Lambda::handleRequest" ]