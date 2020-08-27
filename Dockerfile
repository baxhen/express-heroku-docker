FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:alpine
WORKDIR '/app'
ENV NODE_ENV=production
COPY --from=0 /app/build ./
COPY ../server/package*.json ./
RUN npm install

COPY ../server/ ./

RUN tsc

RUN npm start



