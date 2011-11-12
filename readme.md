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

``` sh
# list applications
curl http://[admin]:[pass]@authur.wilbur.io/applications
```

### Register Application

``` sh
curl -XPUT http://[admin]:[pass]@authur.wilbur.io/applications -d '{ "name": "awesome_sauce" }'
#=> { "success": "true" }
```

### Register User

``` sh
curl -XPUT http://[admin]:[pass]@authur.wilbur.io/users -d '{ "username": "foo", "password": "bar", "confirm": "bar"} '
#=> { "success": "true" }
```

### List users for an application

``` sh
curl http://[admin]:[pass]@authur.wilbur.io/applications/[app]/users 
#=> { "users": ["foo", "bar"]}
```

### Attach User to Application

``` sh
curl -XPUT http://[admin]:[pass]@authur.wilbur.io/applications/[app]/users -d '{"username": "foo"}'
#=> { "success": "true"}
```

### Authenticate User

``` sh
curl -XPOST http://[admin]:[pass]@authur.wilbur.io/applications/[app]/users/[user] -d ' {"password": "bar"}'
#=> { "success": "true"}
```

### User Applications

``` sh
curl http://[admin]:[pass]@authur.wilbur.io/users/[user]/applications
#=> { "applications": ["app1","app2"]}
```

### User Test Authentication

``` sh
curl -XPOST http://[admin]:[pass]@authur.wilbur.io/users/[user] -d '{"password": "bar"}'
#=> { "success": "true" }
```

