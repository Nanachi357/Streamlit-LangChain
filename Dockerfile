# Use an official Python runtime as the base image
FROM python:3.9-slim

# Install necessary system dependencies for both Python and Node.js
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    chromium \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Copy the requirements file into the container
COPY requirements.txt .

# Install Python dependencies from requirements.txt
RUN pip install -r requirements.txt

# Set the working directory for the project
WORKDIR /app

# Install Node.js dependencies for Puppeteer and Puppeteer Stealth
COPY package.json .
RUN npm install

# Copy the entire project into the container
COPY . .

# Set the Puppeteer executable path for Chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Expose Streamlit's default port
EXPOSE 8501

# Set the default command to run both Streamlit and the Puppeteer script
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]