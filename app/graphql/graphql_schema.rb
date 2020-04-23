class GraphqlSchema < GraphQL::Schema
    # Add the plugin for connection pagination
    use GraphQL::Pagination::Connections
    default_max_page_size 50

    # base types
    query(Types::QueryType)
    mutation(Types::MutationType)

  end
  