class Image < ActiveRecord::Base
  belongs_to :albumb
  has_attached_file :avatar, :styles => { :medium => "500x500>", :thumb => ["500x600>", :jpg] }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  acts_as_taggable
  
  
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
