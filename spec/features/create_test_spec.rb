require_relative '../rails_helper'
require_relative '../support/new_task_form.rb'
require_relative '../support/login_form.rb'
feature "Create a task", :js => true do 
	let(:new_task_form) {NewTaskForm.new}
	let(:login_form) {LoginForm.new}
	let(:user) {FactoryBot.create(:user)}

	before do
		visit('/users/sign_in')
		login_as(user, :scope => :user, :run_callbacks => false)
		sleep 4 
	end
	
	it "creates task with valid data" do 
		new_task_form.visit_page.fill_in_with(:name => 'My first task').submit
		expect(page).to have_content("Task has been created")
        expect(Task.last.name).to eq('My first task')
	end
	
	it "does not creates task with invalid data" do 
		new_task_form.visit_page.fill_in_with(:name => '').submit
		expect(page).to have_content("can't be blank")
    end
end 