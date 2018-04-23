#!/bin/bash
set -e

echo "[ ****************** ] Begin install of project"
if ! [ -d "/var/www/portal-vale-cultura" ] || ! [ -d "/var/www/portal-vale-cultura/projeto" ]; then
    echo "Application not found in /var/www/portal-vale-cultura - cloning now..."
    
    echo "[ ****************** ] Cloning Project repository to tmp folder"
    git clone $GIT_REPOSITORY /tmp/portal-vale-cultura
    
    echo "[ ****************** ] Copying Project from temporary folder to workdir"
    cp /tmp/portal-vale-cultura -r /var/www

    echo "[ ****************** ] Copying sample application configuration to real one"
    cp /var/www/portal-vale-cultura/projeto/application/configs/application.ini-example /var/www/portal-vale-cultura/projeto/application/configs/application.ini
    cp /var/www/portal-vale-cultura/projeto/application/configs/db.ini-example /var/www/portal-vale-cultura/projeto/application/configs/db.ini

    echo "SetEnv APPLICATION_ENV $APPLICATION_ENV" > /var/www/portal-vale-cultura/public/.htaccess
    cat /var/www/portal-vale-cultura/public/.htaccess-example >> /var/www/portal-vale-cultura/public/.htaccess
    
    mkdir -p /var/www/portal-vale-cultura/public/imagens/captcha
    chmod 755 /var/www/portal-vale-cultura/public/imagens
    chmod 775 /var/www/portal-vale-cultura/public/imagens/captcha
    
    echo "[ ****************** ] Changing owner and group from the Project to 'www-data' "
    chown www-data:www-data -R /var/www/portal-vale-cultura
    
    
    ls -la /var/www/portal-vale-cultura
fi

echo "[ ****************** ]  Project installed!"

