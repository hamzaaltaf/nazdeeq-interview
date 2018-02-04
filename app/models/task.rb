class Task < ApplicationRecord
	# paginator
	paginates_per 15

	belongs_to :user
	enum privacy: [:public_access, :private_access]
	validates :description, presence: true
	# validates :description, uniqueness: {
	# 	scope: :user_id,
	# 	message: "you can't have two tasks with the same title"
	# }
	# validates :user, presence: true
	enum dev_status: [:done, :pending, :started, :tested, :reassigned]
	enum qa_status: [:tests_pending, :tested_on_dev, :tested_on_demo, :tested_on_live, :its_done]
	enum category: [:consultation, :notifications, :my_consultation_page, :labs, :pharmacy, :receptionist_view, :dependents, :doctor_profile, :payment, :patient_profile, :signin, :emails]
	enum priority: [:not_prioritized ,:low, :medium, :high, :critical]
	enum environment: [:demo, :live, :dev]
	enum product_type: [:core, :corporate, :ice, :receptionist, :mobile_app]
	enum assigned_to: [:not_assigned, :hamza, :mehak, :hassan, :rashid, :samran, :jalil, :qamar]
	enum caused_by: [:neither, :hamza_work, :mehak_work, :samran_work, :rashid_work, :hassan_work, :jail_work]
	enum reported_by: [:no_one, :hamza_altaf, :mehak_fatima, :hassan_siddique, :rashid_shafiq, :samran_rana, :abdul_jalil, :mahak, :noureen]
	enum sprint: [:not_included, :sprint9, :sprint10, :sprint11]
	
	# for fileters on index page 
	
	filterrific(
	    default_filter_params: { with_sprint: "", with_assigned_to: "", with_category: "", with_dev_status: "", with_qa_status: ""},
	    available_filters:     %i[
	      with_sprint
	      with_assigned_to
	      with_category
	      with_dev_status
	      with_qa_status
	    ]
	  )
	
	# scopes for filters
	scope :with_sprint, lambda { |sprint|
		return where(sprint: sprint)
	}

	scope :with_category, lambda { |cat|
		return where(category: cat)
	}

	scope :with_assigned_to, lambda { |person|
		return where(assigned_to: person)
	}

	scope :with_dev_status, lambda { |status|
		return where(dev_status: status)
	}

	scope :with_qa_status, lambda { |status|
		return where(qa_status: status)
	}

	# class methods
	def self.top_scorrer
		# get completed tasks and multiply each task with the level and add scores
		scores_hash = Hash.new
		User.includes(:tasks).where(admin: nil).each do |u|
			score = 0
			tasks = u.tasks.where("completed_at is not null").each do |t|
				score = score + t.level.to_i
			end
			scores_hash[u.email.remove('@augmentcare.com')] = score
		end
		return scores_hash
	end

	def self.check_status(task)
		task.complete ? 'Mark Incomplete' : 'Mark Complete'
	end

	def self.get_total_tasks_data
		total_tasks = Task.all
		chart = Task.get_data(total_tasks)
		return chart
	end

	def self.developers_chart_data
		chart = Hash.new
		users = User.all.pluck(:email).map {|e| e.remove('@augmentcare.com')}
		users.each do |u|
			chart[u] = Task.where("assigned_to = ? AND completed_at is not null", Task.assigned_tos[u]).count
		end
		return chart
	end

	def self.total_hours
		tasks = Task.where("completed_at is not null")
		minutes = 0
		tasks.each do |task|
			minutes = task.time_taken + minutes
		end
		total_hours = minutes/60
		return total_hours
		# total_minutes = minutes%60
	end

	def self.get_data(total_tasks)
		assigned_tasks = total_tasks.not_assigned
		completed_tasks = total_tasks.where("completed_at is not null")
		tested = total_tasks.where(qa_status: 4)
		chart = Hash.new
   	 	chart['total'] = total_tasks.count
    	chart['assigned'] = total_tasks.count - assigned_tasks.count
    	chart['completed'] = completed_tasks.count
    	chart['tested'] = tested.count
    	return chart
	end

	def self.get_a_user_tasks(id)
		tasks = User.find(id).tasks
		return tasks
	end

	def self.get_percentage
		total = Task.total_hours
		# byebug
		return ((total.to_f / 392.to_f)*100).round(2)
	end

	def self.get_user_total_tasks_data(id)
		tasks = User.find(id).tasks
		chart = Task.get_data(tasks)
		return chart
	end




end
