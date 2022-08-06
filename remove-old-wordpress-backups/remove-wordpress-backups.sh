#!/usr/bin/env /bin/bash
set -euo pipefail

###
## GLOBAL VARIABLES
###
DAYS=${DAYS:-'365'}
PATH="/var/www/vhosts/*/wordpress-backups"
FIND="/bin/find"

remove_wordpress_backups () {
    $FIND $PATH -type f -mtime +$DAYS -exec echo rm -f {} +
}

remove_wordpress_backups
