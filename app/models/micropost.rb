class Micropost < ApplicationRecord
  belongs_to :user

  scope :newest_first, ->{order(created_at: :desc)}
  scope :by_user_id, ->(id){where(user_id: id)}
  scope :feeds, (lambda do |id|
    where "user_id IN (SELECT followed_id FROM relationships
      WHERE follower_id = #{id}) OR user_id = #{id}"
  end)

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.maximum_post_length}
  validate :picture_size

  private

  def picture_size
    return unless picture.size > Settings.max_file_size.megabytes
    errors.add(:picture, I18n.t("picture.size"))
  end
end
