class Group < ActiveRecord::Base
  has_many :users
  
  belongs_to :course
  validates_presence_of :course
  belongs_to :assignment
  validates_presence_of :assignment
  
  has_many :grades, :as => :graded
  has_many :earned_badges, :through => :grades
  has_many :badges, :through => :earned_badges
    
  attr_accessible :name, :created_at, :updated_at, :proposal, :approved, :assignment_id
  
end
