# Етап 1: білд
FROM node:20-alpine AS builder

WORKDIR /app

# Копіюємо тільки package.json і lock-файл для швидкого встановлення залежностей
COPY package*.json ./
COPY tsconfig.json ./
COPY next.config.ts ./
COPY postcss.config.mjs ./
COPY eslint.config.mjs ./

RUN npm install

# Копіюємо весь код
COPY ./src ./src

# Білдимо проект
RUN npm run build

# Етап 2: запуск
FROM node:20-alpine

WORKDIR /app

# Встановлюємо тільки продакшн залежності
COPY package*.json ./
RUN npm install --production

# Копіюємо зібраний білд з попереднього етапу
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/next.config.ts ./next.config.ts
COPY --from=builder /app/package.json ./package.json

EXPOSE 3000

CMD ["npm", "start"]