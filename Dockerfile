FROM node:22-slim

WORKDIR /app

# Copy package files
COPY package.json ./

# Use npm install (not npm ci) since lockfile may be out of sync
RUN npm install --ignore-scripts

# Copy source
COPY . .

# Build TypeScript
RUN npm run build

# Start
CMD ["npm", "run", "start"]
