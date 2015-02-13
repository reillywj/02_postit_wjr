module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug!
    class_attribute :slug_col
  end

  def generate_slug!
    base_slug = to_slug(self.send(self.class.slug_col.to_sym))
    potential_slug = base_slug
    obj = self.class.find_by slug: base_slug

    count = 2
    while obj && obj != self
      potential_slug = base_slug + "-" + count.to_s
      obj = self.class.find_by slug: potential_slug
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

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_col = col_name
    end
  end
end