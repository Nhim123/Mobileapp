# Use the official Node.js image as the base image
FROM node:18

# Set environment variables
ENV NODE_ENV=development
ENV ANDROID_SDK_ROOT=/opt/android-sdk

# Install required dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Android SDK
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools && \
    cd $ANDROID_SDK_ROOT/cmdline-tools && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip -O sdk.zip && \
    unzip sdk.zip && rm sdk.zip && mv cmdline-tools latest

# Update PATH for Android tools
ENV PATH="$PATH:$ANDROID_SDK_ROOT/latest/bin:$ANDROID_SDK_ROOT/platform-tools"

# Accept licenses and install essential SDK packages
RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2"

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the Metro bundler port
EXPOSE 8081

# Start the Metro bundler
CMD ["npx", "react-native", "start"]
