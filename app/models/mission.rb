class Mission < ApplicationRecord
  enum status: {pending: 0, progress: 1, done: 2}
  validates :title, presence: true
  validates :status, presence: true
end
