class Article < ApplicationRecord
	mount_uploader :image, ArticleImageUploader

	def self.search(search)
    if search
      where("title ILIKE :search", search: "%#{search}%")
    else
      all
    end
  end
end
