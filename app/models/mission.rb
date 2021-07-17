class Mission < ApplicationRecord
  enum status: {pending: 0, progress: 1, done: 2}
  validates :title, presence: true
  validates :status, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :check_end



  private
  # def check_start
  #   errors.add(:start_time, I18n.t("later_now")) if self.start_time? && self.start_time< Time.now
  # end

  def check_end
    errors.add(:end_at, I18n.t("later_start")) if self.end_time? && self.end_time < self.start_time
  end

end
