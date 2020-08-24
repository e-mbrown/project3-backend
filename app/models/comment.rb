class Comment < ApplicationRecord
  belongs_to :user, :activity
end
