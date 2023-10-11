#
# Laravel
## Simple
```
docker run -ti --rm \
-v $PWD/tb-laravel-test:/projectroot/ \
twistedbytes/setupproject \
-u $(id -u):$(id -g) \
--projecttype simple-laravel
```

# SilverStripe
## Simple
```
docker run -ti --rm \
-v $PWD/tb-silverstripe-test:/projectroot/ \
twistedbytes/setupproject \
-u $(id -u):$(id -g) \
--projecttype simple-silverstripe

cd $PWD/tb-silverstripe-test
docker compose up

```

## With Next
```
docker run -ti --rm \
-v $PWD/tb-silverstripe-next:/projectroot/ \
twistedbytes/setupproject \
-u $(id -u):$(id -g) \
--projecttype silverstripe-with-next
```
