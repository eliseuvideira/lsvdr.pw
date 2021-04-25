#!/usr/bin/env bash

# usage
usage () {
  echo "usage: $PROG_NAME /path/to/file/backup.sql"
}

# exit_with_error $MESSAGE
exit_with_error() {
  echo "$1"
  usage
  exit 1
}

# load_env $ENV_PATH
load_env() {
  IFS=$'\n'
  export $(grep -Ev '^#' "$1" | xargs -0)
  IFS=
}

# restore $PORT $USER $PASSWORD $DATABASE $FILENAME
restore() {
  __BACKUP_BASENAME="$(basename "$5")"
  __POSTGRES_CONTAINER="$(docker-compose ps -q postgres)"

  docker cp "$5" "$__POSTGRES_CONTAINER:/root/"

  docker-compose exec \
    -T \
    --env PGPASSWORD="$3" \
      postgres \
        psql \
          --dbname="$4" \
          --port="$1" \
          --host="localhost" \
          --username="$2" \
          --file="/root/$(basename "$5")"

  docker exec "$__POSTGRES_CONTAINER" /bin/sh -c "rm /root/$__BACKUP_BASENAME"
}

PROG_NAME="$0"
CURRENT_PATH="$(realpath "$(dirname .)")"
SCRIPT_PATH="$(realpath "$(dirname "$0")")"
BACKUP_FILENAME="$(realpath "$1")"

[ $# == 1 ] || exit_with_error "invalid number of parameters"
[ -f "$BACKUP_FILENAME" ] || exit_with_error "backup file doesn't exists"

cd $SCRIPT_PATH

load_env "$SCRIPT_PATH/.env"

restore "$POSTGRES_PORT" "$POSTGRES_USER" "$POSTGRES_PASSWORD" "$POSTGRES_DB" "$BACKUP_FILENAME"

cd $CURRENT_PATH
