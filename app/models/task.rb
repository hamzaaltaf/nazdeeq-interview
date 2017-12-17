class Task < ApplicationRecord
	belongs_to :user
	enum privacy: [:public_access, :private_access]
	validates :name, presence: true
	validates :name, uniqueness: {
		scope: :user_id,
		message: "you can't have two achievements with the same title"
	}
	validates :user, presence: true


	def self.check_status(task)
		task.complete ? 'Mark Incomplete' : 'Mark Complete'
	end

	def self.owner?(task)
		current_user == task.user ? true : false
	end
end
