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
        #  :confirmable,
         :trackable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  # - RELATIONS
  # -

  # - VALIDATIONS
  validates :email, presence: true, length: { maximum: 255 } # Validatable is already checking that the email is valid and unique

  # - CALLBACKS
  # after_initialize ...

  # Send mail through activejob
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  # return first and lastname
  def name
    [first_name, last_name].join(' ').strip
  end
end
