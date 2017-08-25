class Work < ActiveRecord::Base

  belongs_to :user

  attr_accessible :title, :url, :description, :user_id, :tags


  def self.search(search)
    where('tags LIKE ?', "%#{search}%")
  end

end
