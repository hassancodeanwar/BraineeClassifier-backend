# Use an official Python runtime as the base image
FROM python:3.10-slim

# Set environment variables to avoid Python buffering and ensure consistent behavior
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Create and set the working directory
WORKDIR /app

# Copy requirements first to leverage Docker's caching mechanism
COPY requirements.txt .

# Install dependencies with pip
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the application port
EXPOSE 5000

# Define the default command to run the app
CMD ["gunicorn", "-b", "0.0.0.0:5000", "main:app"]
