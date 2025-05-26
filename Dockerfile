# Stage 1: Build Angular
FROM node:18 as build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build -- --output-path=dist

# Stage 2: Servir com nginx
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/dist/cos-projeto /usr/share/nginx/html

# Opcional: copiar configuração customizada do nginx
# COPY nginx.conf /etc/nginx/nginx.conf