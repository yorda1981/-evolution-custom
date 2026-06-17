FROM node:20-slim

WORKDIR /evolution

RUN apt-get update && apt-get install -y \
    git \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch main https://github.com/EvolutionAPI/evolution-api.git .

RUN npm install --legacy-peer-deps

RUN npm install @whiskeysockets/baileys@latest --save --legacy-peer-deps

RUN cp .env.example .env

RUN npx prisma generate --schema ./prisma/postgresql-schema.prisma

RUN npm run build

EXPOSE 8080

CMD ["sh", "-c", "cp -r ./prisma/postgresql-migrations ./prisma/migrations && npx prisma migrate deploy --schema ./prisma/postgresql-schema.prisma && node dist/main"]
