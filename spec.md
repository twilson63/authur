## Authur 0.2.0

## Models

Account
Admin
App
User
Role

## Relationships

Account
 has_many admins
 has_many apps
 has_many users
 
Admin
 belongs_to account
 
 has_many apps
 has_many users
 
App
 belongs_to account
 
 has_many admins through account
 has_many users

Role
  belongs_to account
  has_many users

Users
 belongs_to account
 belongs_to admin
 
 has_many apps
 has_many roles


## API

### Account

schema

- name
- apps
- admins
- users
- workflow_state

actions

GET  /accounts - return all system accounts
POST /accounts - create new account
GET  /accounts/:id - get one account
PUT /accounts/:id - update one account
DELETE /accounts/:id - delete account

### Admin

schema

- username
- password {encrypted}

actions

GET /accounts/:id/admins - get all admins
POST /accounts/:id/admins - create new admin
GET /accounts/:id/admins/:id - get admin
PUT /accounts/:id/admins/:id - update admin
DELETE /accounts/:id/admins/:id - remove admin

### Apps

schema

- name
- account
- users

actions

GET /accounts/:id/apps - get all apps
POST /accounts/:id/apps - create new app
GET /accounts/:id/apps/:id - get app
PUT /accounts/:id/apps/:id - update app
DELETE /accounts/:id/apps/:id - remove app

GET /accounts/:id/apps/:id/users - users for given app
POST /accounts/:id/apps/:id/users - add user to app
DELETE /accounts/:id/apps/:id/users/:id - remove user from app


### Users

- username
- password
- email
- apps


actions

GET /accounts/:id/users - get all admins
POST /accounts/:id/users - create new admin
GET /accounts/:id/users/:id - get admin
PUT /accounts/:id/users/:id - update admin
DELETE /accounts/:id/users/:id - remove admin

GET /accounts/:id/users/:id/apps - apps for given user
POST /accounts/:id/users/:id/apps - add app to user
DELETE /accounts/:id/users/:id/apps/:id - remove app from user

GET /accounts/:id/users/:id/roles - roles for given user
POST /accounts/:id/users/:id/roles - add role to user
DELETE /accounts/:id/users/:id/roles/:id - remove role from user


### Roles

- name
- account

actions

GET /accounts/:id/roles - get all roles
POST /accounts/:id/roles - create new role
GET /accounts/:id/roles/:id - get role
PUT /accounts/:id/roles/:id - update role
DELETE /accounts/:id/roles/:id - remove role

GET /accounts/:id/roles/:id/users - users for given role
POST /accounts/:id/roles/:id/users - add user to role
DELETE /accounts/:id/roles/:id/users/:id - remove user from role






