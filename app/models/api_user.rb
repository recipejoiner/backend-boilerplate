class ApiUser < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Tokenizable
  include ActiveModel::Validations
  # Basic usage of strong_password gem.  Defaults to minimum entropy of 18 and no dictionary checking
  validates :password, password_strength: true

  # Include devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable, 
         :devise,
         :validatable,
         :confirmable,
         :trackable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

end
