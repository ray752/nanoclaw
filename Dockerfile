FROM node:22
WORKDIR /app
RUN npm install -g @anthropic-ai/claude-code
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build
RUN cd container/agent-runner && npm install && npm run build
CMD ["npm", "run", "start"]
