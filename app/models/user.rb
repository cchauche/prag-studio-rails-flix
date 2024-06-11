class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true

  validates :email,
            format: {
              with: /\S+@\S+/
            },
            uniqueness: {
              case_sensitive: false
            }

  validates :username,
            presence: true,
            uniqueness: {
              case_sensitive: false
            },
            format: {
              with: /\A(\w|\d)+\z/,
              message:
                "must consist of only numbers and digits with no white spaces."
            },
            length: {
              minimum: 3
            }
end
