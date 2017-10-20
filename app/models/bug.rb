class Bug < ApplicationRecord

  include Filter

  has_attached_file :screen_shot, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :screen_shot, :content_type => /^image\/(png|gif)/

  belongs_to :creator, class_name: "User"
  belongs_to :user
  belongs_to :project

  validates :bug_type, presence: true
  validates :status, presence: true

  scope :feature, -> { where(bug_type: StatusConstant::FEATURE) }
  scope :bug, -> { where(bug_type: StatusConstant::BUG) }

  enum bug_type: ["feature", "bug"]

  FEATURE_STATUS = ['new', 'started', 'completed']
  BUG_STATUS = ['new', 'started', 'resolved']

  def check_bug
    return self.bug_type == StatusConstant::BUG
  end

  def check_feature
    return self.bug_type == StatusConstant::FEATURE
  end
end
