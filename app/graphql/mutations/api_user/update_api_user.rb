class Mutations::ApiUser::UpdateApiUser < GraphQL::Schema::Mutation

  field :apiUser, Types::ApiUserType, null: false
  description "Update API user"
  argument :password, String, required: false
  argument :newPassword, String, required: false
  argument :newPasswordConfirmation, String, required: false
  argument :email, String, required: false

  def resolve(arguments)
    api_user = context[:current_api_user]
    if !api_user
      GraphQL::ExecutionError.new("No such API user, or not logged in")
    else
      # If trying to change the password
      if !!arguments[:new_password] or !!arguments[:new_password_confirmation]
        if api_user.valid_password?(arguments[:password])
          api_user.update!(
            password: arguments[:new_password],
            password_confirmation: arguments[:new_password_confirmation]
          )
        else
          return GraphQL::ExecutionError.new("Password required to change password")
        end
      end
      api_user.update!(arguments.except(:password, :new_password, :new_password_confirmation))
      {
        api_user: api_user
      }
    end
  end

end