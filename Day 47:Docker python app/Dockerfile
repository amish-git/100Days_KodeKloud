# Python base image
FROM python:3.11-slim-bullseye

# Set working directory
WORKDIR /app

COPY src/requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy all source files to working directory
COPY src/ .

# Expose port 3001 on the container port
EXPOSE 3001

# Start the application
CMD ["python", "server.py"]