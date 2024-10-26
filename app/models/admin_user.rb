class AdminUser < ApplicationRecord
 def self.ransackable_attributes(auth_object = nil)
    %w[id email created_at updated_at]
  end
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
end
