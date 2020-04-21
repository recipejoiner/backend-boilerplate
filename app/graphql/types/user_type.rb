module Types
  class UserType < GraphQL::Schema::Object
    field :id, ID, null: true
    field :name, String, null: true
    field :firstName, String, null: true
    field :lastName, String, null: true
    field :username, String, null: true
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
    def name
      authorized_for_full_info ? self.object.name : nil
    end
    def first_name
      authorized_for_full_info ? self.object.first_name : nil
    end
    def last_name
      authorized_for_full_info ? self.object.last_name : nil
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
