## Start docker
- docker-compose up # stop it -> CTRL-C
- docker-compose up -d # detached start
- docker-compose down # to use if detached

## next npm install
- docker-compose run -ti --rm next /bin/bash
- Then execute these commands in there
    - npx create-next-app@latest app --ts --use-npm
    - mv app/* app/.[a-zA-Z0-9]* .
    - rmdir app
    - exit

## php composer install
- docker-compose run -ti --rm php-cli
    - composer create-project silverstripe/installer .
    - composer require ....
    - php vendor/silverstripe/framework/cli-script.php dev/build
