#!/bin/bash

## Inspired by https://github.com/kojiromike/docker-magento/blob/master/apache/start_safe_perms

##
# Detect the ownership of the webroot
# and run apache as that user.
#
run_apache() {
    local owner group owner_id group_id
    read owner group owner_id group_id < <(stat -c '%U %G %u %g' /var/www)
    if [[ $owner = UNKNOWN ]]; then
        owner=$(randname)
        if [[ $group = UNKNOWN ]]; then
            group=$owner
            addgroup --system --gid "$group_id" "$group"
        fi
        adduser --system --uid=$owner_id --gid=$group_id "$owner"
    fi
    {
        echo "APACHE_RUN_USER=$owner"
        echo "APACHE_RUN_GROUP=$group"
    } >> /etc/apache2/envvars
    # Not volumes, so need to be chowned
    chown -R "$owner:$group" /var/{lock,log,run}/apache*
    exec /usr/sbin/apache2ctl "$@"
}

##
# Generate a random sixteen-character
# string of alphabetical characters
randname() {
    local -x LC_ALL=C
    tr -dc '[:lower:]' < /dev/urandom |
        dd count=1 bs=16 2>/dev/null
}

if [ -n "$ENABLE_APACHE_MODULES" ]; then
    a2enmod $ENABLE_APACHE_MODULES
fi

usr/local/bin/init-php.sh

run_apache "$@"
