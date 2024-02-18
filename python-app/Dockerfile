FROM public.ecr.aws/lambda/python:3.8

# Install unzip package
RUN yum install -y unzip

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
     unzip awscliv2.zip && \
    ./aws/install && \
    rm awscliv2.zip

COPY requirements.txt .
RUN pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"
COPY . ${LAMBDA_TASK_ROOT}
CMD ["app.lambda_handler"]