#!/bin/bash
# Docker entrypoint script.

# Wait until Postgres is ready
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

echo "Creating and migrating database..."
mix do ecto.create, ecto.migrate
echo "Database created."

echo "Starting server..."
exec mix phx.server