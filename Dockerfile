# Base image
FROM python:3.9-slim

# Install cron and git
RUN apt-get update && apt-get install -y cron git unixodbc-dev 

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Install curl
#RUN apt-get update && apt-get install -y curl

# Expose the port
EXPOSE 4747

# Copy the scripts
COPY Queries /app

# Set execution permissions for the cron script
#RUN chmod +x /app/cron_script.sh

# Set up cron job
# RUN crontab /app/crontab.txt

# Command to run the application and start the cron job
CMD uvicorn main:app --host 0.0.0.0 --port 4747
