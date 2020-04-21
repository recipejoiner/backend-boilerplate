module Regex
  class Email
    VALIDATE = /\A(\w+)([\w+\-.]+)(\w+)(@)([a-z\d]+)([a-z\d\-\.]+)([a-z\d]+)(\.)([a-z]+)\z/i
    # Explaining that email regex:
    # /             start of regex
    # \A            match start of string
    # \w+           at least one word character
    # [\w+\-.]+     at least one word character, plus a hyphen or dot
    # \w+           at least one word character
    # @             exactly one literal at sign
    # [a-z\d]+      at least one letter or digit
    # [a-z\d\-.]+   at least one letter, digit, hyphen, or dot
    # [a-z\d]+      at least one letter or digit
    # \.            exactly one literal dot
    # [a-z]+        at least one letter
    # \z            match end of string
    # /             end of regex
    # i             case insensitive
    #
    # Check here for regex rules: https://rubular.com
  end
end