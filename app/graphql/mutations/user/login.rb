class Mutations::User::Login < GraphQL::Schema::Mutation

  field :user, Types::UserType, null: false

  description "Login for users"
  argument :email, String, required: true
  argument :password, String, required: true
  # payload_type Types::UserType 

  def resolve(email:, password:)
    user = User.find_for_authentication(email: email)
    if !user
      GraphQL::ExecutionError.new("No such user")    
    else
      is_valid_for_auth = user.valid_for_authentication?{
        user.valid_password?(password)
      }
      if is_valid_for_auth
        {
          user: user
        }
      else
        GraphQL::ExecutionError.new("Incorect password")
      end
    end
  end

end