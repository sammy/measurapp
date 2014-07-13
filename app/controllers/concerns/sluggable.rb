module Sluggable
  extend ActiveSupport::Concern

  def generate_slug
    slug = self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/,'')
    if self.class.where(:slug => slug).count > 0
      n = 1
      while self.class.where(:slug => "#{slug}-#{n}").count > 0
        n += 1
      end
      self.slug = "#{slug}-#{n}"
    else
      self.slug = "#{slug}"
    end 
  end

  def to_param
    self.slug
  end

end