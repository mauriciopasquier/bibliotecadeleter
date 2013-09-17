# encoding: utf-8
class Link < ActiveRecord::Base
  belongs_to :linkeable, polymorphic: true, touch: true
end
