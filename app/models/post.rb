class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  belongs_to :moderator

  validates :title, presence: true
  validates :content, presence: true

  def self.matching_title_or_content search
  	where("title LIKE? OR content LIKE ?", "%#{search}%", "#{search}%")
  end

  def self.filter_by_tags param_tag
  	includes(:tags).where(publish: true, tags: {name: param_tag}).order(id: :desc)
  end
end
