class Mutations::User::SignUp < GraphQL::Schema::Mutation

  field :user, Types::UserType, null: false

  description "Sign up for users"
  argument :attributes, Types::UserInputType, required: true

  def resolve(attributes:)
    user = User.create(attributes.to_kwargs)
    if user.persisted?
      context[:current_user] = user
      {
        user: user
      }
    else
      user.errors.full_messages.each { |message|
        context.add_error(GraphQL::ExecutionError.new(message))
      }
      nil # return nil
    end
  end
end