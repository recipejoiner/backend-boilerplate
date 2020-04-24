# Rails 6 API-only boilerplate with devise & JWT & graphQL. Including implementation of OmniAuth!

A starter project for any Ruby on Rails GraphQL API, including both custom auth and OmniAuth!

It's designed to be a good starting point for any frontend-agnostic API, and implements [JSON Web Tokens](https://jwt.io/introduction/) for authentication.

This boilerplate includes support for two users: normal users, and API users. All requests (other than signing up and logging in) must be authenticated, so the API User model exists so that a frontend can authenticate for non-logged in users.

Once the user is logged in, it is expected that the user's token will be passed in *instead* of the API user's token.

Tokens should be in the header of your request, and formatted like so, per the JWT specs:
`Authorization: Bearer <token>`

OAuth has been implemented for Facebook logins via the [OmniAuth Facebook](https://github.com/simi/omniauth-facebook) gem. See below for instructions on using the current implementation.

## Versions

- Current ruby version `2.6.x`
- Bundler version `2.1.4`
- Rails version `6.0.X`
- Postgres Server as db connector

## Quick start

clone the repo:

```sh
git clone https://github.com/recipejoiner/backend-boilerplate
cd backend-boilerplate
```

Clone `env_sample` to .env for local development. We set it up with default rails `3000` ports. You'll also want to replace the value of some/all of the environment vars:

```sh
cp env_sample .env
```

Install the bundle:

```sh
bundle install
```

Make sure postgres is running on localhost. You may have to change your credentials under `/config/database.yml`:

```sh
rake db:create
rake db:migrate
rake db:seed
```

Run the development server:

```
rails s
```

Because this is an API-only application you will not be able to access any routes via browser. Download a GraphQL client like [Insomnia](https://insomnia.rest/) or others. 

Point the GraphQL IDE to `http://localhost:3000/graphql/`

## Using OmniAuth
[Devise `:omniauthable`](https://github.com/heartcombo/devise/wiki/OmniAuth:-Overview) been implemented for the User model, and must be configured before use. The only configuration that needs to be done is:
- Register for a FB dev account, as it says here: <https://developers.facebook.com/docs/facebook-login/web>
- Create a new app. Name it whatever you like. You can do this [here](https://developers.facebook.com/apps/).
- In your app, go to basic settings. Add `localhost` to your app domain if you'll be testing locally, as well as any other domain that your app lives on. 
- On the above settings page, you have your App ID as well as your App Secret (click 'show'). Copy these into their rightful place in your .env file, via the env_sample from earlier.

# User flow
- User visits the following url: `http://localhost:3000/users/auth/facebook/` (in production, replace localhost with your API's URL)
- User logs in
- Implemented in the callback located in `app/controller/users/omniauth_callbacks_controller.rb`, the user is then authenticated either by the UID and provider information included in the response from Facebook. If these aren't set on a matching user, the script will attempt to authenticate via their email. If that doesn't exist on a user either, a new user will be created for them, using their name on Facebook for their username, first_name, and last_name, and it'll store their email as well.

Note: If a user signs up via OAuth, they can still update their name/username/email. You may want to prompt users to update this information, especially because their username will have a random string of letters at the end of it to ensure uniqueness.

## What's included?

### 1. Database
The app uses a postgresql database. It implements the connector with the gem `pg`. The app already includes `User` and `API User` models with basic setup.

### 2. Authentication
The app uses [devise](https://github.com/plataformatec/devise)'s logic for authentication. Emails are not totally configured. OmniAuth is also configured for the `User` model.

### 3. Authorization
Authorization logic is handled first in the GraphQL controller, which ensures that users are logged in before executing queries. Note that this is done with regex, and is therefore not totally secure. But that's okay, because authorization is also handled (mostly) within the GraphQL logic!

Some examples:
- Unless a user is an admin, the only information that they can see about other users is their username
- Passwords are required for changing a password

etc.

### 4. JSON Web Token
[devise-jwt](https://github.com/waiting-for-dev/devise-jwt) is a devise extension which uses JWT tokens for user authentication. It follows [secure by default](https://en.wikipedia.org/wiki/Secure_by_default) principle.

### 5. GraphQL
[graphql-ruby](https://github.com/rmosolgo/graphql-ruby) is a Ruby implementation of GraphQL. Sadly it's not 100% open source, but with the free version you can do some amazing things. See the [Getting Started Guide](https://graphql-ruby.org/) and the current implementations in this project under `app/graphql/`.

### 6. App server
The app uses [Puma](https://github.com/puma/puma) as the web serber. It is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications in development and production.

### 7. Testing

We are using the wonderful framework [rspec](https://github.com/rspec/rspec). The testsuit also uses [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails) for fixtures. 

Run `rspec spec` 

### 8. Deployment
The project runs on any host with ruby installed. Its only dependency is a PostgreSQL database. Create a block `production:` in the`config/database.yml` for your connection.



## What's missing?

* Specs for devise lockable
* Implementation for devise confirmable


Feel free to join development!

## Author

Based originally on [zauberware's rails-devise-graphql starter](https://github.com/zauberware/rails-devise-graphql)

__Script:__ <https://github.com/recipejoiner/backend-boilerplate>

__Author GitHub:__ [https://github.com/arimendelow/](https://github.com/arimendelow/)

__Author LinkedIn:__ [http://linkedin.com/in/amendelow](http://linkedin.com/in/amendelow)
