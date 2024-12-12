# Build Stage
FROM node:16-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install --force
COPY . .
RUN npm run build
 
# Production Stage
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY ./nginx-conf /etc/nginx/conf.d
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]