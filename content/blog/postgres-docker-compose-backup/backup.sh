#!/usr/bin/env bash

# load_env $ENV_PATH
load_env() {
  IFS=$'\n'
  export $(grep -Ev '^#' "$1" | xargs -0)
  IFS=
}

# backup $PORT $USER $PASSWORD $DATABASE
backup() {
  docker-compose exec \
    -T \
    --env PGPASSWORD="$3" \
      postgres \
        pg_dump \
          --dbname="$4" \
          --port="$1" \
          --host="localhost" \
          --username="$2"
}


CURRENT_PATH="$(realpath "$(dirname .)")"
SCRIPT_PATH="$(realpath "$(dirname "$0")")"
BACKUP_PATH="$SCRIPT_PATH/backups"
BACKUP_FILENAME="$BACKUP_PATH/$(date +%Y%m%d%H%M%S).sql.gz"

cd $SCRIPT_PATH

load_env "$SCRIPT_PATH/.env"

[ -d "$BACKUP_PATH" ] || mkdir "$BACKUP_PATH"

backup "$POSTGRES_PORT" "$POSTGRES_USER" "$POSTGRES_PASSWORD" "$POSTGRES_DB" | gzip > "$BACKUP_FILENAME"

cd $CURRENT_PATH
