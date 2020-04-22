class User < ApplicationRecord
  include ActiveModel::Dirty # https://api.rubyonrails.org/classes/ActiveModel/Dirty.html
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Tokenizable
  include ActiveModel::Validations
  # Basic usage of strong_password gem.  Defaults to minimum entropy of 18 and no dictionary checking
  # validates :password, password_strength: true
  # Another method of password validation:
  PASSWORD_REQUIREMENTS = /\A
    (?=.{8,}) # at least 8 chars long
    (?=.*\d) # at least one number
    (?=.*[a-z]) # at least one lowercase letter
    (?=.*[A-Z]) # at least one uppercase letter
    (?=.*[[:^alnum:]]) # at least one symbol
  /x

  validates :password, format: PASSWORD_REQUIREMENTS, if: :password_required_for_action

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable, 
         :devise,
         :validatable,
         :trackable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  # add new roles to the end
  enum role: %i[customer admin]

  # - RELATIONS
  # -

  # - VALIDATIONS
  validates :email, presence: true, length: { maximum: 255 } # Validatable is already checking that the email is valid and unique
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :username, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false } # Rails infirs that uniqueness should be true in addition to case insensitive

  # - CALLBACKS
  after_initialize :setup_new_user, if: :new_record?

  # Send mail through activejob
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  # return first and lastname
  def name
    [first_name, last_name].join(' ').strip
  end

private
  
  def setup_new_user
    self.role ||= :customer
  end

  def password_required_for_action
    # Add any changes that you want to require a password for. eg:
    # self.username_changed? or
    #   self.id_changed? or
    #   self.email_changed? or
    #   self.first_name_changed? or
    #   self.last_name_changed?
    if self.encrypted_password_changed?
      return true
    end
    return false
  end

end
