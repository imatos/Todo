class Task < ActiveRecord::Base
  validates :content, presence: true, uniqueness: true

  belongs_to :user

  enum status: [ :todo, :doing, :done ]
end
