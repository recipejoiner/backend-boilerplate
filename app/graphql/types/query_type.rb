module Types
  class QueryType < BaseObject
    # For getting info about the current user
    field :me, resolver: Resolvers::Me
    field :all_users, [UserType], null: false, resolver: Resolvers::AllUsers
    field :user_by_id, UserType, null: true, resolver: Resolvers::UserByID do
      argument :id, ID, required: true
    end
  end
end
  