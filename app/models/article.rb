class Article < ApplicationRecord
  include Mongoid::Document

  # has_many :comments, class_name => 'Comment'
  field :title, type: String
  field :text, type: String
  field :pdf_url, type: String
  validates :title, presence: true,
                    length: { minimum: 5}
end
