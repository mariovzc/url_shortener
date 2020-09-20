require 'mongoid'
Mongoid.load!(File.join(File.dirname(__FILE__), 'mongoid.yml'))

class Link
  include Mongoid::Document

  field :url, type: String
  field :slug, type: String
  field :clicked, type: Integer, default: 0

  validates :url, 
            presence: true, 
            uniqueness: true,
            format: URI::regexp(%w[http https]), 
            length: {
              in: 3..255,
              message: "too long"
            }, 
            on: :create

  validates :slug, 
            uniqueness: true, 
            length: { 
              in: 3..255,
              message: "too long"
            },
            on: :create

  before_validation :generate_slug

  def generate_slug
    self.slug = SecureRandom.uuid[0..5] if self.slug.nil? || self.slug.empty?
    true
  end

  def set_clicked
    self.clicked = self.clicked + 1
    self.save
  end

  def to_json
    #require 'pry'; binding.pry
    {
      clicked: self.clicked,
      slug: self.slug,
      url: self.url,
      id: self.id.to_str
    }
  end
end