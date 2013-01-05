class Link < ActiveRecord::Base
  attr_accessible :url

  belongs_to :linkeable
end
