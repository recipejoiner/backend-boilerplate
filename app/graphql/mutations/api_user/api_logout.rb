class Mutations::ApiUser::ApiLogout < GraphQL::Schema::Mutation

  null true
  description "Logout for users"
  payload_type Boolean

  def resolve
    if context[:current_api_user]
      # When a token is dispatched for a user, the jti claim is taken from the jti column in the model (which has been initialized when the record has been created).
      # At every authenticated action, the incoming token jti claim is matched against the jti column for that user. The authentication only succeeds if they are the same.
      # When the user requests to sign out its jti column changes, so that provided token won't be valid anymore.
      # That's what's happening here - we're changing the JTI column
      context[:current_api_user].update!(jti: SecureRandom.uuid)
      return true
    end 
    false
  end
end