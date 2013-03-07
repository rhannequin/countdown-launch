class Ctdown < ActiveRecord::Base
  attr_accessible :goal, :slug, :title

  validates :goal, :slug, :title, :presence => true
  validates :slug, :uniqueness => true
end
