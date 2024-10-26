class User < ApplicationRecord
  enum user_type: { developer: 0, manager: 1, qa: 2 }

  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users

  has_many :bugs, foreign_key: :developer_id 

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true
  validates :user_type, presence: true

 def self.ransackable_attributes(auth_object = nil)
    %w[id name email created_at updated_at user_type]
 end

 def self.ransackable_associations(auth_object = nil)
    %w[bugs project_users projects]
 end
  
 def display_name_with_type
    "#{name} (#{user_type.capitalize})" 
 end
end

