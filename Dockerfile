FROM node:20
WORKDIR /usr/src/app
COPY app/package*.json ./
RUN npm install
COPY app .
CMD ["npm", "test"]
