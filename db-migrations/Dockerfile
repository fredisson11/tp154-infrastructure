FROM python:3.13-slim

WORKDIR /app
COPY . .
RUN pip install alembic psycopg2-binary python-dotenv

CMD ["alembic", "upgrade", "head"]