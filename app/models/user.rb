class User
  include Mongoid::Document
  field :name, type: String
  field :addr, type: String
end
