class Link < ActiveRecord::Base
  attr_accessible :url, :nombre

  belongs_to :linkeable
end
