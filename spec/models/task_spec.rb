require 'rails_helper'

RSpec.describe Task, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "validations" do
  	#all these 3 cases can be reduced to 3 lines using shoulda-matchers gem
  	it "checks the presence of the name" do
       	task = Task.new(name: '')
       	expect(task.valid?).to be_falsy
      end

      it "ask for unique name for one user" do
      	user = FactoryBot.create(:user)
      	task_one = FactoryBot.create(:public_task, name: 'My user task', user: user)
      	task = Task.new(name: 'My user task', user: user)
		expect(task.valid?).to be_falsy
       end

       it "allows different users to have tasks with same names" do
       		user1 = FactoryBot.create(:user)
       		user2 = FactoryBot.create(:user)
       		first_task = FactoryBot.create(:public_task, name: 'Task1', user: user1)
       		second_task = Task.new(name: 'Task1', user: user2)
       		expect(second_task.valid?).to be_truthy 
       	end
	end
end
