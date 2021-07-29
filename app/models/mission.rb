class Mission < ApplicationRecord
  enum status: {pending: 0, progress: 1, done: 2}
  enum priority: {low: 0, middle: 1, high: 2}
  validates :title, presence: true
  validates :status, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :check_end
  belongs_to :user

  has_many :tag_lists, dependent: :destroy
  has_many :tags, through: :tag_lists

   
  def self.tagged_with(category)
    Tag.find_by!(category: category).missions
  end

  def tag_items
    tags.map(&:category).join(', ')
  end

  def tag_items=(categories)
    self.tags = categories.split(',').map do |item|
      Tag.where(category: item.strip).first_or_create!
    end
  end


  def tag_items
    tags.map(&:category)
  end

  def tag_items=(categories)
    self.tags = categories.map do |item|
      Tag.where(category: item.strip).first_or_create! unless item.blank?
    end.compact!
  end

  # def tag_items_view
  #   tags.map do |tag|
  #     %Q(<span class="tag">#{tag.category}</span>)
  #   end.join(' ')
  # end



  private

  def check_end
    errors.add(:end_time, I18n.t("later_start")) if self.end_time? && self.end_time < self.start_time
  end

end
