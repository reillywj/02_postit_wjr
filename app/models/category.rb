class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories
  validates :name, presence: true, length: {maximum: 20}, uniqueness: true
  before_save :generate_slug

  def generate_slug
    base_slug = to_slug(self.name)
    potential_slug = base_slug
    category = Category.find_by slug: base_slug

    count = 2
    while category && category != self
      potential_slug = base_slug + "-" + count.to_s
      category = Category.find_by slug: potential_slug
      count += 1
    end
    self.slug = potential_slug
  end

  def to_slug(str)
    output = str.parameterize.downcase
    output
  end

  def to_param
    self.slug
  end
end