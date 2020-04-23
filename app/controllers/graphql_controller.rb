class GraphqlController < ApplicationController

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user,
      current_api_user: current_api_user,
      login: method(:sign_in)
    }
    # This is a Proc for scope reasons - otherwise, wouldn't be able to access current_user, query, etc
    can_execute_queries = lambda do
      is_not_logged_in = (not current_user and not current_api_user)
      if is_not_logged_in
        is_whitelisted_query = [
          "login(",
          "apiLogin(",
          "signUp(",
          "apiSignUp(",
          "sendResetPasswordInstructions(",
          "resetPassword(",
          "query IntrospectionQuery" # query to get the schema
        ].any? { |queryFragment| query.include?(queryFragment)}
        if is_whitelisted_query
          return true
        else
          return false
        end
      else
        # logged in
        return true
      end
    end
    if can_execute_queries.call # need .call because is a Proc
      result = GraphqlSchema.execute(
        query,
        variables: variables,
        context: context,
        operation_name: operation_name
      )
      render json: result
    else
      render json: {'errors': [{'message': "You need to log in! Only sign-up/login queries/mutations are avilable with no authentication."}]}
    end
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private
  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { 
      error: { 
        message: e.message, 
        backtrace: e.backtrace 
      }, 
      data: {} 
    }, status: 500
  end
end
  