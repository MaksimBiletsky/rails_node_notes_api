FROM node:14
ENV NODE_ENV=production
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY . .
EXPOSE 3001
CMD ["node", "server.js"]
