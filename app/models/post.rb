class Post < ApplicationRecord
	mount_uploader :image, ImageUploader
    validates :title, :summary, :body, presence: true
    acts_as_commontable
end
