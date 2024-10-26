class Project < ApplicationRecord
 belongs_to :user
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  has_many :bugs, dependent: :destroy 

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
 def self.ransackable_attributes(auth_object = nil)
    %w[id name description created_at updated_at user_id]
 end

 def developers
    users.where(user_type: 'developer')
 end

  def qas
    users.where(user_type: 'qa')
  end
  accepts_nested_attributes_for :users
end
