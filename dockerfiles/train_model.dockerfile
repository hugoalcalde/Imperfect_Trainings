# Base image
FROM python:3.11-slim

# Install DVC dependencies
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*



# Set up Google Cloud SDK and authenticate
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin
RUN gcloud auth activate-service-account --key-file=imperfect-training-a827b028141a.json

# Install DVC
RUN pip install dvc
RUN pip install dvc[gs]

# Set working directory
WORKDIR /

# Copy DVC files
COPY .dvc/ .dvc/

# Run DVC pull to fetch data
RUN dvc pull

