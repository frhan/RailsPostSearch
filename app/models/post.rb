class Post < ActiveRecord::Base
  include Searchable
  belongs_to :location
  has_and_belongs_to_many :categories

  validates_presence_of :title
  validates_presence_of :location
end
