module Regex
  class Password
    PASSWORD_REQUIREMENTS = /\A
      (?=.{8,}) # at least 8 chars long
      (?=.*\d) # at least one number
      (?=.*[a-z]) # at least one lowercase letter
      (?=.*[A-Z]) # at least one uppercase letter
      (?=.*[[:^alnum:]]) # at least one symbol
    /x
  end
  class Username
    USERNAME_REQUIREMENTS = /\A[a-z]{2,}\z/xi
  end
end