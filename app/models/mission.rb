class Mission < ApplicationRecord
  enum status: {pending: 0, progress: 1, done: 2}
end
