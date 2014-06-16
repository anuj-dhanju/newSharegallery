class Albumb < ActiveRecord::Base
  belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  def self.search(search)
    if search
      where('name LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end
end
