 require_relative '../rails_helper'
require_relative '../support/login_form.rb'

feature "Sign up a user" do
	let(:login_in_form) {LoginForm.new}
	let(:user) {FactoryBot.create(:test_user)}
	it "signs in user with email and password" do 
		login_in_form.visit_page.login_as(user)
		expect(page).to have_content("Signed in successfully.")
		expect(page).to have_content("Create New Task")
	end
end