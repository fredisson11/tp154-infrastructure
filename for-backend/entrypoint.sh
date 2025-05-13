#!/bin/sh

set -e

# 🔧 Replace __SPACE__ with spaces
export EMAIL_HOST_PASSWORD="${EMAIL_HOST_PASSWORD//__SPACE__/ }"

echo "Applying database migrations..."
python /app/manage.py migrate --noinput

echo "Collecting static files..."
python /app/manage.py collectstatic --noinput

echo "Starting server..."
exec "$@"