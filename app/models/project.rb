class Project < ApplicationRecord

  include Filter

  has_and_belongs_to_many :users
  has_many :bugs
  
end
