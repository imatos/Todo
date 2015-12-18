class Task < ActiveRecord::Base
  belongs_to :user

  enum status: [ :todo, :doing, :done ]
end
