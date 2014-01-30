class InfoController < ApplicationController
  helper_method :sort_column, :sort_direction, :predictions

  before_filter :ensure_staff?, :except => [ :dashboard ]

  def dashboard
    if current_user.is_student?
      @scores_for_current_course = current_student.scores_for_course(current_course)
    end
    if current_course.team_challenges?
      @events = current_course_data.assignments.timelineable.to_a + current_course.challenges
    else
      @events = current_course_data.assignments.timelineable.to_a
    end
  end

  def grading_status
    @team = current_course.teams.find_by(id: params[:team_id]) if params[:team_id]
    @students = current_course.users.students
    user_search_options = {}
    user_search_options['team_memberships.team_id'] = params[:team_id] if params[:team_id].present?
    @ungraded_submissions = current_course.submissions.ungraded
    @count_ungraded = @ungraded_submissions.count
    @badges = current_course.badges.includes(:tasks)
  end

  def leaderboard
    @teams = current_course.teams.includes(:earned_badges)
    @students = current_course.users.students.joins(:course_memberships).where('course_memberships.auditing = false')
    @top_ten_students = @students.order_by_high_score.limit(10)
    @bottom_ten_students = @students.order_by_low_score.limit(10)
  end


  #grade index export
  def gradebook
    @assignments = current_course.assignments
    @students = current_course.users.students.includes(:grades)
    respond_to do |format|
      format.html
      format.json { render json: @assignments }
      format.csv { send_data @assignments.gradebook_for_course(current_course) }
      format.xls { send_data @assignments.to_csv(col_sep: "\t") }
    end
  end

end
