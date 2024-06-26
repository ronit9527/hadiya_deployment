# Use the official Node.js 20 image
FROM node:18

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install application dependencies
RUN npm install -g npm@10.2.5
RUN npm install
RUN npm install express


# Install PM2 globally
#RUN npm install pm2 -g

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port on which your Node.js application will run
EXPOSE 3000

# Start the application using PM2
CMD ["node", "src/index.js", "--no-daemon"]

