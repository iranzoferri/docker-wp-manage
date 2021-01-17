#!/bin/bash
source .env

# All the paths in .env file
base_path=${BASE_PATH_WP}
docker_volumes=${BASE_PATH_WP_VOLUMES}
docker_volume_backups=${BASE_PATH_WP_VOLUME_BACKUPS}

# Down the project
function dc_down() {
  docker-compose -f ${base_path}/${1}/docker-compose.yaml down
}

# Up the project
function dc_up() {
  docker-compose -f ${base_path}/${1}/docker-compose.yaml down
}

# Rsync files 
function backup() {
  rsync -avP ${docker_volumes}/${1}_* \
             ${docker_volume_backups}/ --delete
}

# Iterate through directories, down, backup and ready on up!
for docker_compose_dir in $(ls ${base_path}/)
do
  dc_down ${docker_compose_dir}
  backup ${docker_compose_dir}
  dc_up ${docker_compose_dir}
done