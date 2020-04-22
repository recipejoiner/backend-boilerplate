class Mutations::ApiUser::ApiLogin < GraphQL::Schema::Mutation

  field :api_user, Types::ApiUserType, null: false, description: "API User Information"

  description "Login for API users"
  argument :email, String, required: true
  argument :password, String, required: true

  def resolve(email:, password:)
    api_user = ApiUser.find_for_authentication(email: email)
    if !api_user
      GraphQL::ExecutionError.new("No such user")    
    else
      is_valid_for_auth = api_user.valid_for_authentication?{
        api_user.valid_password?(password)
      }
      if is_valid_for_auth
        context[:current_api_user] = api_user
        {
          api_user: api_user
        }
      else
        GraphQL::ExecutionError.new("Incorect password")
      end
    end
  end
end
