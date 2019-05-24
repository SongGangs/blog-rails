class Comment < ApplicationRecord
  include Mongoid::Document

  belongs_to :article, :class_name => 'Article', :foreign_key => 'article_id', optional: true
  field :commenter, type: String
  field :body, type: String

end
