class Tag < ApplicationRecord
  has_many :tag_lists, dependent: :destroy
  has_many :missions, through: :tag_lists, dependent: :destroy
end
