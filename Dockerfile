# Etapa 1: Build da aplicação
FROM node:18 as build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build -- --output-path=dist

# Etapa 2: Servir os arquivos com NGINX
FROM nginx:alpine

# Remove configuração default do nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia os arquivos Angular buildados para a pasta pública do nginx
COPY --from=build /app/dist/cos-projeto-gcloud /usr/share/nginx/html

# Copia uma configuração customizada do nginx (opcional)
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]