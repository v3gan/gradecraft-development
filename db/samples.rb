user_names = ['Ron Weasley','Fred Weasley','Harry Potter','Hermione Granger','Colin Creevey','Seamus Finnigan','Hannah Abbott','Pansy Parkinson','Zacharias Smith','Blaise Zabini', 'Draco Malfoy', 'Dean Thomas', 'Millicent Bulstrode', 'Terry Boot', 'Ernie Macmillan']

team_names = ['Harm & Hammer', 'Abusement Park','Silver Woogidy Woogidy Woogidy Snakes','Carpe Ludus','Eduception','Operation Unthinkable','Team Wang','The Carpal Tunnel Crusaders','Pwn Depot']

badge_names = ['Dream Interpreter', 'Inner Eye', 'Patronus Producer','Cheerful Charmer','Invisiblity Cloak','Marauders Map','Lumos','Rune Reader','Tea Leaf Guru','Wizard Chess Grand Master','Green Thumb','Gamekeeper','Seeker','Alchemist','Healer','Parseltongue','House Cup']

badge_icons = ['/badges/above_and_beyond.png','/badges/always_learning.png','/badges/awesome_aggregator.png','/badges/concentrator.png','/badges/courageous_failure.png','/badges/early_bird_special.png','/badges/examination_expert.png','/badges/gaining_experience.png','/badges/gamer.png','/badges/great_critic.png','/badges/learning_from_mistakes.png','/badges/level_one.png','/badges/participatory_democrat.png','/badges/personal.png','/badges/practice_makes_perfect.png','/badges/presentation_of_self.png','/badges/public_speaker.png']

grade_scheme_hash = { [0,600000] => 'F', [600000,649000] => 'D+', [650000,699999] => 'C-', [700000,749999] => 'C', [750000,799999] => 'C+', [800000,849999] => 'B-', [850000,899999] => 'B', [900000,949999] => 'B+', [950000,999999] => 'A-', [100000,1244999] => 'A', [1245000,1600000] => 'A+'}

majors = ['Obliviator','Knight Bus Driver','Magizoologist','Wandmaker','Mediwizard','Dragonologist','Floo Network Regulator','Curse-Breaker','Broom-maker','Arithmancer','Hit Wizard','Auror']

# Generate sample courses
course = Course.create! do |c|
  c.name = "Videogames & Learning"
  c.courseno = "ED222"
  c.year = Date.today.year
  c.semester = "Winter"
  c.total_assignment_weight = 6
  c.max_assignment_weight = 6
  c.default_assignment_weight = 1
  c.max_group_size = 3
  c.min_group_size = 5
  c.team_setting = true
  c.teams_visible = true
  c.group_setting = true
  c.badge_setting = true
  c.badge_use_scope = "Both"
  c.shared_badges = true
  c.badges_value = true
  c.accepts_submissions = true
  c.predictor_setting = true
  c.graph_display = false
  c.tagline = "You Game the Grade"
  c.academic_history_visible = true
  c.media_file = "http://www.youtube.com/watch?v=LOiQUo9nUFM&feature=youtu.be"
  c.media_credit = "Albus Dumbledore"
  c.media_caption = "The Greatest Wizard Ever Known"
  c.office = "Room 4121 SEB"
  c.phone = "734-644-3674"
  c.class_email = "staff-educ222@umich.edu"
  c.twitter_handle = "barryfishman"
  c.twitter_hashtag = "EDUC222"
  c.location = "Whitney Auditorium, Room 1309 School of Education Building"
  c.office_hours = "Tuesdays, 1:30 pm – 3:30 pm"
  c.meeting_times = "Mondays and Wednesdays, 10:30 am – 12:00 noon"
  c.badge_term = "Achievement"
  c.user_term = "Learner"
  c.assignment_term = "Quest"
  c.group_term = "League"
  c.team_term = "Horde"
  c.challenge_term = "Battle"
  c.grading_philosophy ="I believe a grading system should put the learner in control of their own destiny, promote autonomy, and reward effort and risk-taking. Whereas most grading systems start you off with 100% and then chips away at that “perfect grade” by averaging in each successive assignment, the grading system in this course starts everyone off at zero, and then gives you multiple ways to progress towards your goals. Different types of assignments are worth differing amounts of points. Some assignments are required of everyone, others are optional. Some assignments can only be done once, others can be repeated for more points. In most cases, the points you earn for an assignment are based on the quality of your work on that assignment. Do poor work, earn fewer points. Do high-quality work, earn more points. You decide what you want your grade to be. Learning in this class should be an active and engaged endeavor."
end
puts "Videogames and Learning has been installed"

teams = team_names.map do |team_name|
  course.teams.create! do |t|
    t.name = team_name
  end
end
puts "The Team Competition has begun!"

# Generate sample students
students = user_names.map do |name|
  first_name, last_name = name.split(' ')
  username = name.parameterize.sub('-','.')
  User.create! do |u|
    u.username = username
    u.first_name = first_name
    u.last_name = last_name
    u.email = "#{username}@hogwarts.edu"
    u.password = 'uptonogood'
    u.courses << course
    u.teams << teams.sample
  end
end
puts "Generated #{students.count} unruly students"

# Generate sample admin
User.create! do |u|
  u.username = 'albus'
  u.first_name = 'Albus'
  u.last_name = 'Dumbledore'
  u.role = 'admin'
  u.email = 'dumbledore@hogwarts.edu'
  u.password = 'fawkes'
 u.courses << course
end
puts "Albus Dumbledore just apparated into Hogwarts"

# Generate sample professor
User.create! do |u|
  u.username = 'severus'
  u.first_name = 'Severus'
  u.last_name = 'Snape'
  u.role = 'professor'
  u.email = 'snape@hogwarts.edu'
  u.password = 'lily'
  u.courses << course
end
puts "Severus Snape has been spotted in Slytherin House"

# Generate sample GSI
students << User.create! do |u|
  u.username = 'percy.weasley'
  u.first_name = 'Percy'
  u.last_name = 'Weasley'
  u.role = 'gsi'
  u.email = 'percy.weasley@hogwarts.edu'
  u.password = 'bestprefect'
  u.courses << course
end
puts "Percy Weasley has arrived on campus, on time as usual"

students.each do |s|
  StudentAcademicHistory.create! do |ah|
    ah.student_id = s.id
    ah.major = majors.sample
    ah.gpa = [1.5, 2.0, 2.25, 2.5, 2.75, 3.0, 3.33, 3.5, 3.75, 4.0, 4.1].sample
    ah.current_term_credits = rand(12)
    ah.accumulated_credits = rand(40)
    ah.year_in_school = [1, 2, 3, 4, 5, 6, 7].sample
    ah.state_of_residence = "Michigan"
    ah.high_school = "Hogwarts School of Witchcraft & Wizardry"
    ah.athlete = [false, true].sample
    ah.act_score = 1 * rand(10)
    ah.sat_score = 100 * rand(10)
  end
end
puts "And gave students some background"

rubric = course.rubrics.create! do |r|
  r.name = "The Rubric"
  r.description = "Test Rubric"
end

criteria = 1.upto(3).map do |n|
  criteria = rubric.criteria.create! do |c|
    c.name = "Criterium #{n}"
    c.category = %w(Category1 Category2 Category3).sample
  end
end

criteria.each do |criterium|
  1.upto(3).each do |n|
    criterium.levels.create! do |l|
      l.name = "Level #{n}"
      l.value = 100 * n
    end
  end
end

assignment_types = {}

#Generate badge set
badge_set = course.badge_sets.create! do |bs|
  bs.name = "Hogwarts Most Officially Official Badge Set"
end
puts "Awards may now be given!"

badges = badge_names.map do |badge_name|
  badge_set.badges.create! do |b|
    b.name = badge_name
    b.point_total = 100 * rand(10)
    b.icon = badge_icons.sample
    b.visible = 1
  end
end
puts "Did someone need motivation? We found these badges in the Room of Requirements..."

assignment_types[:attendance] = AssignmentType.create! do |at|
  at.course = course
  at.name = "Attendance"
  at.point_setting = "By Assignment"
  at.points_predictor_display = "Fixed"
  at.resubmission = false
  at.max_value = "120000"
  at.predictor_description = "We will work to build a learning community in EDUC 222, and I want this to be a great learning experience for all. To do this requires that you commit to the class and participate."
  at.universal_point_value = "5000"
  at.due_date_present = true
  at.order_placement = 1
  at.mass_grade = true
  at.mass_grade_type = "Checkbox"
  at.student_logged_button_text = "I'm in class!"
  at.student_logged_revert_button_text = "I couldn't make it"
end
puts "Come to class."

assignment_types[:reading_reaction] = AssignmentType.create! do |at|
  at.course = course
  at.name = "Reading Reactions"
  at.point_setting = "By Assignment"
  at.points_predictor_display = "Select List"
  at.resubmission = false
  at.predictor_description = "Each week, you must write a concise summary or analysis of the reading for that week of no more than 200 words! (200 words is roughly equivalent to one-half page, double-spaced.) Your 201st word will suffer a terrible fate... "
  at.due_date_present = true
  at.order_placement = 2
  at.mass_grade = true
  at.mass_grade_type = "Select"
  at.student_weightable = true
end
puts "Do your readings."

assignment_types[:blogging] = AssignmentType.create! do |at|
  at.course = course
  at.name = "Blogging"
  at.point_setting = "By Assignment"
  at.points_predictor_display = "Slider"
  at.resubmission = false
  at.max_value = "60000"
  at.predictor_description = "The course blog allows you to reflect on your learning, or to report on and/or critique ideas and reports about games and learning that you encounter in your daily travels online and offline."
  at.order_placement = 3
  at.mass_grade = true
  at.mass_grade_type = "Radio"
  at.student_weightable = true
end
puts "Blogging is great for filling in missed points in other areas"

assignment_types[:lfpg] = AssignmentType.create! do |at|
  at.course = course
  at.name = "Learning from Playing a Game"
  at.point_setting = "By Assignment"
  at.points_predictor_display = "Slider"
  at.resubmission = false
  at.due_date_present = true
  at.order_placement = 4
  at.mass_grade = false
  at.student_weightable = true
end
puts "This is the good stuff :)"

assignment_types[:boss_battle] = AssignmentType.create! do |at|
  at.course = course
  at.name = "Boss Battles"
  at.point_setting = "By Assignment"
  at.points_predictor_display = "Slider"
  at.resubmission = false
  at.due_date_present = true
  at.order_placement = 5
  at.mass_grade = false
end
puts "Challenges!"

grinding_assignments = []

1.upto(10).each do |n|
  grinding_assignments << assignment_types[:attendance].assignments.create! do |a|
    a.name = "Class #{n}"
    a.point_total = 5000
    a.due_at = rand(n - 6).weeks.ago
    a.accepts_submissions = false
    a.release_necessary = false
    a.grade_scope = "Individual"
    a.student_logged = true
    if n == 2
      a.open_at = 1.day.ago
      a.due_at = 1.day.from_now
    end
  end

  grinding_assignments << assignment_types[:reading_reaction].assignments.create! do |a|
    a.name = "Reading Reaction #{n}"
    a.point_total = 5000
    a.due_at = rand(n - 6).weeks.ago
    a.accepts_submissions = false
    a.release_necessary = true
    a.grade_scope = "Individual"
    a.rubrics << rubric
  end
end

grinding_assignments.each do |a|
  a.tasks.create! do |t|
    t.taskable = a
    t.name = "Task 1"
    t.due_at = rand.weeks.from_now
    t.accepts_submissions = true
  end
end

puts "Attendance and Reading Reaction classes have been posted!"

grinding_assignments.each do |assignment|
  next unless assignment.due_at.past?
  students.each do |student|
    assignment.tasks.each do |task|
      submission = student.submissions.create! do |s|
        s.task = task
        s.text_comment = "Wingardium Leviosa"
        s.link = " "
      end
      student.grades.create! do |g|
        g.submission = submission
        g.raw_score = assignment.point_total * [0, 1].sample
      end
    end
  end
end
puts "Attendance and Reading Reaction scores have been posted!"

blog_assignments = []

1.upto(5).each do |n|
  blog_assignments << Assignment.create! do |a|
    a.assignment_type = assignment_types[:blogging]
    a.name = "Blog Post #{n}"
    a.point_total = 5000
    a.accepts_submissions = true
    a.release_necessary = false
    a.grade_scope = "Individual"
    a.rubrics << rubric
  end

  blog_assignments << Assignment.create! do |a|
    a.assignment_type = assignment_types[:blogging]
    a.name = "Blog Comment #{n}"
    a.point_total = 2000
    a.accepts_submissions = true
    a.release_necessary = false
    a.grade_scope = "Individual"
  end
end

blog_assignments.each do |a|
  a.tasks.create! do |t|
    t.name = "Task 1"
    t.due_at = rand.weeks.from_now
    t.accepts_submissions = true
  end
end

puts "Blogging assignments have been posted!"

blog_assignments.each_with_index do |assignment, i|
  next if i % 2 == 0
  students.each do |student|
    assignment.tasks.each do |task|
      submission = student.submissions.create! do |s|
        s.task = task
        s.text_comment = "Wingardium Leviosa"
        s.link = " "
      end
      student.grades.create! do |g|
        g.submission = submission
        g.raw_score = assignment.point_total * [0, 1].sample
      end
    end
  end
end
puts "Blogging scores have been posted!"

assignments = []

assignments << Assignment.create! do |a|
  a.assignment_type = assignment_types[:lfpg]
  a.name = "Game Selection Paper"
  a.point_total = 80000
  a.due_at = rand(3).weeks.ago
  a.accepts_submissions = true
  a.release_necessary = true
  a.open_at = rand(3).weeks.ago
  a.grade_scope = "Individual"
  a.save
  a.tasks.create! do |t|
    t.name = "Task 1"
    t.due_at = rand.weeks.from_now
    t.accepts_submissions = true
  end
  students.each do |student|
    a.tasks.each do |task|
      submission = student.submissions.create! do |s|
        s.task = task
        s.text_comment = "Wingardium Leviosa"
        s.link = " "
      end
      student.grades.create! do |g|
        g.submission = submission
        g.raw_score = 80000 * [0,1].sample
      end
    end
  end
end
puts "Game Selection Paper has been posted!"

assignments << Assignment.create! do |a|
  a.assignment_type = assignment_types[:lfpg]
  a.name = "Game Play Update Paper 1"
  a.point_total = 120000
  a.due_at = rand(3).weeks.from_now
  a.accepts_submissions = true
  a.release_necessary = true
  a.open_at = rand(2).weeks.from_now
  a.grade_scope = "Individual"
end
puts "Game Play Update Paper 1 has been posted!"

assignments << Assignment.create! do |a|
  a.assignment_type = assignment_types[:lfpg]
  a.name = "Game Play Update Paper 2"
  a.point_total = 120000
  a.due_at = rand(4).weeks.from_now
  a.accepts_submissions = true
  a.release_necessary = true
  a.open_at = rand(3).weeks.from_now
  a.grade_scope = "Individual"
end
puts "Game Play Update Paper 2 has been posted!"

assignments << Assignment.create! do |a|
  a.assignment_type = assignment_types[:lfpg]
  a.name = "Game Play Reflection Paper"
  a.point_total = 160000
  a.due_at = rand(5).weeks.from_now
  a.accepts_submissions = true
  a.release_necessary = true
  a.open_at = rand(4).weeks.from_now
  a.grade_scope = "Individual"
end
puts "Game Play Reflection Paper has been posted!"

assignments << Assignment.create! do |a|
  a.assignment_type = assignment_types[:boss_battle]
  a.name = "Individual Paper/Project 1"
  a.point_total = 200000
  a.due_at = rand(4).weeks.from_now
  a.accepts_submissions = true
  a.release_necessary = true
  a.open_at = rand(3).weeks.from_now
  a.grade_scope = "Individual"
end
puts "Individual Project 1 has been posted!"

assignments << Assignment.create! do |a|
  a.assignment_type = assignment_types[:boss_battle]
  a.name = "Individual Paper/Project 2"
  a.point_total = 300000
  a.due_at = rand(5).weeks.from_now
  a.accepts_submissions = true
  a.release_necessary = true
  a.open_at = rand(4).weeks.from_now
  a.grade_scope = "Individual"
end
puts "Individual Project 2 has been posted!"

assignments << Assignment.create! do |a|
  a.assignment_type = assignment_types[:boss_battle]
  a.name = "Group Game Design Project"
  a.point_total = 400000
  a.due_at = rand(7).weeks.from_now
  a.accepts_submissions = true
  a.release_necessary = true
  a.open_at = rand(6).weeks.from_now
  a.grade_scope = "Group"
end
puts "Group Game Design has been posted!"

grade_scheme = GradeScheme.new(:name => 'N.E.W.T. Grades')
grade_scheme_hash.each do |range,letter|
  grade_scheme.elements.new do |e|
    e.letter = letter
    e.low_range = range.first
    e.high_range = range.last
  end
end
puts "Installed N.E.W.T. grade scheme for each course"

challenges = []

challenges << Challenge.create! do |c|
  c.course = course
  c.name = "House Cup"
  c.point_total = 1000000
  c.due_at = rand(7).weeks.from_now
  c.accepts_submissions = true
  c.release_necessary = true
  c.open_at = rand(6).weeks.from_now
  c.visible = true
end
puts "The House Cup Competition begins... "

challenges << Challenge.create! do |c|
  c.course = course
  c.name = "Tri-Wizard Tournament"
  c.point_total = 10000000
  c.due_at = rand(8).weeks.from_now
  c.accepts_submissions = true
  c.release_necessary = true
  c.open_at = rand(8).weeks.from_now
  c.visible = true
end
puts "Are you willing to brave the Tri-Wizard Tournament?"

LTIProvider.create! do |p|
  p.name = 'Piazza'
  p.uid = 'piazza'
  p.launch_url = 'https://piazza.com/connect'
  p.consumer_key = 'piazza.sandbox'
  p.consumer_secret = 'test_only_secret'
end
