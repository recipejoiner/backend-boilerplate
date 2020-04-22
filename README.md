# Rails 6 API-only boilerplate with devise & JWT & graphQL

This is a boilerplate to build your next SaaS product. It's a RubyOnRails 6 API only backend with Authentication and GraphQL API. It works nicely together with clients made with **React.js & React.Native** or any other frontend which implements the [JSON Web Tokens](https://jwt.io/introduction/) philosophy.

## Versions

- Current ruby version `2.6.x`
- Bundler version `2.1.4`
- Rails version `6.0.X`
- Postgresql Server as db connector

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

## What's included?

### 1. Database
The app uses a postgresql database. It implements the connector with the gem `pg`. The app already includes a `User` model with basic setup.

### 2. Authentication
The app uses [devise](https://github.com/plataformatec/devise)'s logic for authentication. Emails are not totally configured.

### 3. JSON Web Token
[devise-jwt](https://github.com/waiting-for-dev/devise-jwt) is a devise extension which uses JWT tokens for user authentication. It follows [secure by default](https://en.wikipedia.org/wiki/Secure_by_default) principle.

### 4. GraphQL
[graphql-ruby](https://github.com/rmosolgo/graphql-ruby) is a Ruby implementation of GraphQL. Sadly it's not 100% open source, but with the free version you can do some amazing things. See the [Getting Started Guide](https://graphql-ruby.org/) and the current implementations in this project under `app/graphql/`.

### 5. App server
The app uses [Puma](https://github.com/puma/puma) as the web serber. It is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications in development and production.

### 6. Testing

We are using the wonderful framework [rspec](https://github.com/rspec/rspec). The testsuit also uses [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails) for fixtures. 

Run `rspec spec` 

### 7. Deployment
The project runs on any host with ruby installed. Its only dependency is a PostgreSQL database. Create a block `production:` in the`config/database.yml` for your connection.



## What's missing?

* Specs for devise lockable
* Implementation for devise confirmable
* Implementation for omniauthable


Feel free to join development!

## Author

__Script:__ <https://github.com/zauberware/rails-devise-graphql>  
__Author website:__ [https://www.zauberware.com](https://www.zauberware.com)    

![zauberware technologies](https://avatars3.githubusercontent.com/u/1753330?s=200&v=4)
