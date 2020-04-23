class ApiUser < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Tokenizable
  include ActiveModel::Validations
  # Basic usage of strong_password gem.  Defaults to minimum entropy of 18 and no dictionary checking
  # validates :password, password_strength: true
  # Another method of password validation is in the Regex lib

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
  validates :password, format: Regex::Password::PASSWORD_REQUIREMENTS, if: :password_required_for_action
  validates :email, presence: true, length: { maximum: 255 } # Validatable is already checking that the email is valid and unique

  # - CALLBACKS
  # after_initialize ...

  # Send mail through activejob
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

private
  def password_required_for_action
    # Add any changes that you want to require a password for. eg:
    #   self.id_changed? or
    #   self.email_changed?
    if self.encrypted_password_changed?
      return true
    end
    return false
  end
end
