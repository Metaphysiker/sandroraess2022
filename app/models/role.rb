class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, :through => :user_roles

  def self.role_names
    ["admin"]
  end
end
