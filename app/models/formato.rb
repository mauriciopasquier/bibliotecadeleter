# encoding: utf-8
class Formato < ActiveRecord::Base
  include FriendlyId

  has_and_belongs_to_many :expansiones

  friendly_id :nombre, use: :slugged
end
