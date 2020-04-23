class GraphqlSchema < GraphQL::Schema
    # Add the plugin for connection pagination
    use GraphQL::Pagination::Connections

    # base types
    query(Types::QueryType)
    mutation(Types::MutationType)

  end
  