# build environment
FROM node:13.12.0-alpine as build
#ARG REACT_APP_BACKEND_URL
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
ENV REACT_APP_BACKEND_URL="http://127.0.0.1:8700/api"

COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

# production environment
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]