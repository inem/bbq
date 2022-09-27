class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :body, presence: true
  validates :user_name, presence: true, unless: -> { user.present? }

  def author
    AuthorTypes.author(self)
  end
end
