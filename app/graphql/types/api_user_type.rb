module Types
  class ApiUserType < GraphQL::Schema::Object
    field :id, ID, null: true
    field :email, String, null: true
    field :token, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

    def authorized_for_full_info
      if context[:current_user] != nil
        if context[:current_user].id == self.object.id or context[:current_user].admin?
          return true
        end
      end
      return false
    end

    def id
      authorized_for_full_info ? self.object.id : nil
    end
    def email
      authorized_for_full_info ? self.object.email : nil
    end
    def token
      authorized_for_full_info ? self.object.token : nil
    end
    def created_at
      authorized_for_full_info ? self.object.created_at : nil
    end
    def updated_at
      authorized_for_full_info ? self.object.updated_at : nil
    end
  end
end
