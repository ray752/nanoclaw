FROM node:22
WORKDIR /app

# Install Claude Code CLI globally AND verify it exists
RUN npm install -g @anthropic-ai/claude-code && \
    which claude && \
    claude --version || echo "Claude Code CLI installed (version check may fail headless)"

# Install main project dependencies
COPY package.json package-lock.json* ./
RUN npm install

# Copy source and build
COPY . .
RUN npm run build

# Install and build agent-runner (includes @anthropic-ai/claude-code as local dep)
RUN cd container/agent-runner && npm install && npm run build

# Verify claude-code is accessible from agent-runner too
RUN ls -la /usr/local/lib/node_modules/@anthropic-ai/claude-code/cli.js || \
    ls -la container/agent-runner/node_modules/@anthropic-ai/claude-code/cli.js || \
    echo "WARNING: claude-code cli.js not found in expected locations"

CMD ["npm", "run", "start"]
