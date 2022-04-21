#
 - docker run -ti --rm -v $PWD/tb-laravel-test:/projectroot/ twistedbytes/setupproject -u $(id -u):$(id -g) --projecttype simple-laravel
 - docker run -ti --rm -v $PWD/tb-silverstripe-test:/projectroot/ twistedbytes/setupproject -u $(id -u):$(id -g) --projecttype simple-silverstripe
