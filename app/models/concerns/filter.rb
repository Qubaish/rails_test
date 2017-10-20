module Filter
  extend ActiveSupport::Concern

  included do
    validates :title, uniqueness: true, presence: true
  end

  def self.included(base)
    base.class_eval do
      scope :newest_first, -> { order("created_at DESC") }
    end
  end
  
end
