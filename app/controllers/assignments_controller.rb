class AssignmentsController < ApplicationController
  before_filter :ensure_staff?, :except => [:feed, :show, :index]

  def index
    @title = "#{term_for :assignment} Index"
  end

   def settings
    @title = "#{term_for :assignments} Settings"
  end

  def show
    @assignment = current_course.assignments.find(params[:id])
    @title = @assignment.name
    @groups = @assignment.groups
    @team = current_course.teams.find_by(id: params[:team_id]) if params[:team_id]
    if current_user.is_student?
      if @assignment.accepts_submissions?
        @submission = @assignment.submissions.new
      end
      if @assignment.has_groups?
        @group = current_course.groups.find(params[:group_id])
      else
        @student = current_user
      end
    end
  end

  def new
    @title = "Create a New #{term_for :assignment}"
    @assignment = current_course.assignments.new
  end

  def edit
    @assignment = current_course.assignments.find(params[:id])
    @title = "Edit #{@assignment.name}"
    @assignment_rubrics = current_course.rubric_ids.map do |rubric_id|
      @assignment.assignment_rubrics.where(rubric_id: rubric_id).first_or_initialize
    end
  end

  def create
    @assignment = current_course.assignments.new(params[:assignment])
    if @assignment.due_at < @assignment.open_at
      redirect_to new_assignment_path, :notice => 'Due date must be after open date.'
    elsif @assignment.save
      respond_with @assignment, :location => assignment_path(@assignment), :notice => 'Assignment was successfully created.'
    else
      respond_with @assignment
    end
  end

  def update
    @assignment = current_course.assignments.find(params[:id])
    if @assignment.due_at < @assignment.open_at
      redirect_to edit_assignment_path(@assignment), :notice => 'Due date must be after open date.'
    elsif @assignment.update_attributes(params[:assignment])
      respond_with @assignment
    end
  end

  def destroy
    @assignment = current_course.assignments.find(params[:id])
    @assignment.destroy
    redirect_to assignments_url
  end

  def feed
    @assignments = current_course.assignments
    respond_with @assignments.with_due_date do |format|
      format.ics do
        render :text => CalendarBuilder.new(:assignments => @assignments.with_due_date ).to_ics, :content_type => 'text/calendar'
      end
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:assignment_rubrics_attributes => [:id, :rubric_id, :_destroy])
  end
end
