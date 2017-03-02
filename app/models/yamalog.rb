class Yamalog < ActiveRecord::Base
  validates :user_id, presence: true
  validates :yama_date, presence: true
  validates :yama_name, length: { maximum: 20 }, presence: true
  validates :weather, length: { maximum: 10 }, presence: true
  validates :member, presence: true
  validates :route, presence: true
  validate :yama_date_should_be_before_current_date

  belongs_to :user

  mount_uploader :yamalog_pic1, YamalogPicUploader
  mount_uploader :gpslog, GpslogUploader

  def created_by?(user)
    return false unless user
    user_id == user.id
  end

  def self.search(search)
    if search
      Yamalog.where(['yama_name LIKE ?', "%#{search}%"])
    else
      Yamalog.all
    end
  end

  private

  def yama_date_should_be_before_current_date
    return unless yama_date

    if yama_date > Date.today
      errors.add(:yama_date, 'は今日よりも前に設定してください')
    end
  end
end
