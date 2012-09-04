class Course < ActiveRecord::Base
  attr_accessible :badge_set_ids, :course_grade_scheme_id, :courseno, :name, :semester, :theme_id, :year, :badge_setting, :team_setting, :team_term, :user_term, :user_id, :course_id, :homepage_message, :group_setting, :user_weight_amount, :user_weight_amount_close_date, :team_roles, :section_leader_term, :group_term, :user_weight_amount_type
  
  has_and_belongs_to_many :users, :join_table => :course_memberships, :uniq => true
  accepts_nested_attributes_for :users
  
  has_many :assignments, :dependent => :destroy
  has_many :assignment_types, :dependent => :destroy
  has_and_belongs_to_many :badge_sets, :join_table => :course_badge_sets
  has_many :badges, :through => :badge_sets
  has_many :earned_badges, :through => :users
  has_many :grade_schemes, :dependent => :destroy
  has_many :grade_scheme_elements, :through => :grade_schemes
  belongs_to :course_grade_scheme
  has_many :course_grade_scheme_elements, :through => :course_grade_scheme
  has_many :grades, :through => :assignments
  has_many :groups, :dependent => :destroy
  has_many :teams, :dependent => :destroy
  has_many :team_assignments, :dependent => :destroy
  belongs_to :theme
  
  def user_ref
    if user_term?
      user_term
    else 
      "Player"
    end
  end
  
  def team_ref
    if team_term?
      team_term
    else 
      "Team"
    end
  end
  
  def group_ref
    if group_term?
      group_term
    else 
      "Group"
    end
  end
  
  def section_leader_ref
    if section_leader_term?
      section_leader_term
    else 
      "Team Leader"
    end
  end
  
  def has_teams?
    team_setting == true
  end
  
  def has_badges?
    badge_setting == true
  end
  
  def has_groups?
    group_setting == true
  end
  
  def team_roles?
    team_roles == true
  end
  
  def total_points
    assignments.sum(:point_total)
  end
  
  def score_for_student(student)
   student.sortable_score
  end

  
  def grade_level(student)
    course_grade_scheme.grade_level(score_for_student(student)) || "Not yet known"
  end
  
end
