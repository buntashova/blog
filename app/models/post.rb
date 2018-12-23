class Post < ApplicationRecord
    validates :title, :summary, :body, presence: true
    acts_as_commontable
end
