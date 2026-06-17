FROM atendai/evolution-api:v2.2.3

WORKDIR /evolution

RUN npm install @whiskeysockets/baileys@latest --save --legacy-peer-deps

EXPOSE 8080

CMD ["npm", "run", "start:prod"]
