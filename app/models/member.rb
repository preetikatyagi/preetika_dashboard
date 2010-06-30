class Member < ActiveRecord::Base
  
  belongs_to	:gene
  belongs_to	:concept
  
  validates_presence_of	:gene
  validates_presence_of	:concept
  
end
