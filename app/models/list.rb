class List < ApplicationRecord
  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true

  has_many :tasks, dependent: :destroy
end
