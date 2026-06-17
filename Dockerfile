FROM node:20-slim

WORKDIR /evolution

RUN apt-get update && apt-get install -y \
    git \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch main https://github.com/EvolutionAPI/evolution-api.git .

RUN npm install --legacy-peer-deps

RUN npm install @whiskeysockets/baileys@6.7.0 --save --legacy-peer-deps

RUN cp .env.example .env

RUN npm run build

EXPOSE 8080

CMD ["npm", "run", "start:prod"]
