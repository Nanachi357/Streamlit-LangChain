# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set environment variables to prevent prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive

# Add necessary Debian repositories
RUN echo "deb http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian bullseye-updates main" >> /etc/apt/sources.list

# Update and install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    chromium \
    npm && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js from the NodeSource repository
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Set the working directory for the project
WORKDIR /app

# Copy all project files into the container
COPY . /app/

# Copy Node.js scripts and other project files into the container
COPY node-scripts/ /app/node-scripts/

# Ensure Node.js dependencies are installed
RUN if [ -d "/app/node-scripts" ]; then npm install --prefix /app/node-scripts; fi

# Install Python dependencies from requirements.txt
RUN pip install -r /app/requirements.txt

# Set Puppeteer environment variable to point to Chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Expose Streamlit's default port
EXPOSE 8501

# Set the default command to run Streamlit when the container starts
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]

# Debugging: List all files in /app after copying everything
RUN ls -la /app/
RUN ls -la /app/node-scripts/
