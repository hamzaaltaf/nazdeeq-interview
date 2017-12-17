require_relative '../rails_helper'
require_relative '../support/new_task_form.rb'
require_relative '../support/login_form.rb'

feature "Create a task", javascript: true do
	let(:new_task_form) {NewTaskForm.new}
	let(:login_in_form) {LoginForm.new}
	let(:user) {FactoryBot.create(:test_user)}
	
	before do
		login_in_form.visit_page.login_as(user)
	end
	
	it "creates task with valid data" do 
		new_task_form.visit_page.fill_in_with(:name => 'My first task').submit
		expect(page).to have_content("Task has been created")
        expect(Task.last.name).to eq('My first task')
	end
	
	it "does not create task with invalid data" do 
		new_task_form.visit_page.fill_in_with(:name => '').submit
		expect(page).to have_content("can't be blank")
    end
end 