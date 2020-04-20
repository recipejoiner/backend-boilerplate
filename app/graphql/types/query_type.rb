module Types
  class QueryType < BaseObject
    # For getting info about the current user
    field :me, resolver: Resolvers::Me
    field :all_users, [UserType], null: false, resolver: Resolvers::AllUsers
  end
end
  