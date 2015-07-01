#!/bin/bash

# install composer for mac

#curl
curl -sS https://getcomposer.org/installer | php

#php
#php -r "readfile('https://getcomposer.org/installer');" | php

sudo mv composer.phar /usr/local/bin/composer

echo 'install composer success.'
