class GraphqlSchema < GraphQL::Schema
    query(Types::QueryType)
    mutation(Types::MutationType)

    # Override this hook to handle cases when `authorized?` returns false for an object:
    def self.unauthorized_object(error)
      # Add a top-level error to the response instead of returning nil:
      raise GraphQL::ExecutionError, "An object of type #{error.type.graphql_name} was hidden due to permissions"
    end

    # Override this hook to handle cases when `authorized?` returns false for a field:
    def self.unauthorized_field(error)
      # Add a top-level error to the response instead of returning nil:
      raise GraphQL::ExecutionError, "The field #{error.field.graphql_name} on an object of type #{error.type.graphql_name} was hidden due to permissions"
    end
  end
  