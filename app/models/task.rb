class Task < ActiveRecord::Base
  validates :content, presence: true

  validates :content, uniqueness: {scope: [:content, :user]}

  belongs_to :user

  enum status: [ :todo, :doing, :done ]
end
