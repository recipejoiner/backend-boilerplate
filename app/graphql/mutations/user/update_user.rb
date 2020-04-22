class Mutations::User::UpdateUser < GraphQL::Schema::Mutation

  field :user, Types::UserType, null: false
  description "Update user"
  argument :password, String, required: false
  argument :newPassword, String, required: false
  argument :newPasswordConfirmation, String, required: false
  argument :email, String, required: false
  argument :firstName, String, required: false
  argument :lastName, String, required: false
  argument :username, String, required: false

  def resolve(arguments)
    user = context[:current_user]
    if !user
      GraphQL::ExecutionError.new("No such user")
    else
      # If trying to change the password
      if !!arguments[:new_password] or !!arguments[:new_password_confirmation]
        if user.valid_password?(arguments[:password])
          user.update!(
            password: arguments[:new_password],
            password_confirmation: arguments[:new_password_confirmation]
          )
        else
          return GraphQL::ExecutionError.new("Password required to change password")
        end
      end
      user.update!(arguments.except(:password, :new_password, :new_password_confirmation))
      {
        user: user
      }
    end
  end

end