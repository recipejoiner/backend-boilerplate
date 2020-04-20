class Resolvers::AllUsers < GraphQL::Schema::Resolver
  
  type Types::UserType, null: false
  description 'Returns all users'

  def resolve
    authenticate
    User.all
  end

end