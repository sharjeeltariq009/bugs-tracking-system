class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :user 
  belongs_to :developer, class_name: 'User', optional: true 

  mount_uploader :screenshot, ScreenshotUploader 

  
  enum category: { bug: 0, feature: 1 }
  enum status: { not_started: 0, started: 1, resolved: 2, completed: 3 }


  
  validates :title, presence: true, uniqueness: { scope: :project_id, message: "Bug with this title already exists" }

  validates :category, :status, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :deadline, presence: true
  validates :screenshot, format: { with: /\.(png|gif)\z/i, message: "Only .png or .gif formats are allowed" }, allow_blank: true

  validate :deadline_cannot_be_in_the_past
  private
 
  def deadline_cannot_be_in_the_past
    if deadline.present? && deadline < Time.current
      errors.add(:deadline, "can't be in the past")
    end
  end

  def screenshot_format
    if screenshot.present? && !screenshot.file.content_type.in?(%w[image/png image/gif])
      errors.add(:screenshot, "must be a GIF or PNG image")
    end
  end
    def self.ransackable_attributes(auth_object = nil)
    ["category", "created_at", "deadline", "description", "developer_id", "id", "project_id", "screenshot", "status", "title", "updated_at", "user_id"]
    end
  
  def self.ransackable_associations(auth_object = nil)
    ["developer", "project", "user"]
  end
end
