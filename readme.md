# Disclaimer
## Work in Progress

# Authur

An application authentication library, focused on super fast authentication for
api's and simple shared applications.

## Why

Every api call via any rest client needs to be authenticated often times, authenticating to 
a data store is extremely time consuming, this library uses the Memcached protocol and
Couchbase to make authentication persistent and fast.  You could also use redis, but for
a first run, we will use CouchBase 2.

## Api

Authur is an authentication api, that supports the ability to let one user log into multiple
applications.  This will require an application to register to the authentication library and
must be a unique name.  Then a user can also register to authur, then the application administrator
can associate a user and an application.

### Applications

### Register Application

``` sh
curl -XPUT http://[admin]:[pass]@authur.wilbur.io/applications -d '{ "name": "app1" }' -H 'Content-Type: application/json'
#=> { "success": "true" }
```

### Register User

``` sh
curl -XPUT http://[admin]:[pass]@authur.wilbur.io/users/[user] -d '{"password": "bar", "confirm": "bar"} ' -H 'Content-Type: application/json'
#=> { "success": "true" }
```

### Attach User to Application

``` sh
curl -XPOST http://[admin]:[pass]@authur.wilbur.io/users/[user]/apps/[app] -H 'Content-Type: application/json'
#=> { "success": "true"}
```

### Authenticate User

``` sh
curl -XPOST http://[admin]:[pass]@authur.wilbur.io/auth/[app] -d ' {"username": "foo", password": "bar"}' -H 'Content-Type: application/json'
#=> { "success": "true"}
```