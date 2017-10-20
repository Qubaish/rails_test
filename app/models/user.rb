class User < ApplicationRecord

  enum user_type: ["developer", "manager", "qa"]
  devise :database_authenticatable, :registerable, :recoverable, stretches: 12
  has_many :bugs
  has_many :created_bugs, class_name: 'Bug', :foreign_key => 'creator_id'

  scope :developers, -> { where(user_type: RoleConstant::DEVELOPER) }

  has_and_belongs_to_many :projects
  validates :name, presence: true
  validates :user_type, presence: true

  def has_role role
    return self.user_type == role
  end

end
