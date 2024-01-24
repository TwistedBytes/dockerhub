## Start docker
- docker compose up # stop it -> CTRL-C
- docker compose up -d # detached start
- docker compose down # to use if detached

## php composer install
- docker-compose run -ti --rm php-cli
    - composer create-project silverstripe/installer .
    - composer require ....
    - php vendor/silverstripe/framework/cli-script.php dev/build
