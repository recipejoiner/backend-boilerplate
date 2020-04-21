class Resolvers::UserByID < GraphQL::Schema::Resolver
  
  type Types::UserType, null: true
  description 'Returns the user with the given ID'

  def resolve(id: nil)
    user = User.find_by(id: 1)
  end

end