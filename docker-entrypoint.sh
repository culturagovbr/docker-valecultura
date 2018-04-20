set -e

if ! [ -d "/var/www/portal-vale-cultura" ] || ! [ -d "/var/www/portal-vale-cultura/projeto" ]; then
    git clone $GIT_REPOSITORY /tmp/portal-vale-cultura

    cp /tmp/portal-vale-cultura -r /var/wwwB

    cp /var/www/portal-vale-cultura/projeto/application/configs/application.ini-example /var/www/portal-vale-cultura/projeto/application/configs/application.ini
    chown www-data:www-data -R /var/www/portal-vale-cultura
fi

