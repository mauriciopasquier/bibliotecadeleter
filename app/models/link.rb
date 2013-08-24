# encoding: utf-8
class Link < ActiveRecord::Base
  attr_accessible :url, :nombre

  belongs_to :linkeable, polymorphic: true, touch: true
end
