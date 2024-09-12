# Usa una imagen base de Node.js
FROM node:14

# Crear el directorio de la aplicación
WORKDIR /usr/src/app

# Copiar el archivo package.json e instalar dependencias
COPY package*.json ./
RUN npm install

# Copiar el código de la aplicación
COPY . .

# Exponer el puerto en el que se ejecutará la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD [ "npm", "start" ]
