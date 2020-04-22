class Mutations::ApiUser::ApiSignUp < GraphQL::Schema::Mutation

  field :api_user, Types::ApiUserType, null: false, description: "API User Information"

  description "Sign up for API users"
  argument :attributes, Types::ApiUserInputType, required: true

  def resolve(attributes:)
    api_user = ApiUser.create(attributes.to_kwargs)
    if api_user.persisted?
      context[:current_user] = api_user
      {
        api_user: api_user
      }
    else
      api_user.errors.full_messages.each { |message|
        context.add_error(GraphQL::ExecutionError.new(message))
      }
      nil # return nil
    end
  end
end