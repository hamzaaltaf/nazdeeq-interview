 require_relative '../rails_helper'
require_relative '../support/sign_up_form.rb'

feature "Sign up a user" do
	let(:new_user) {SignUpForm.new}
	it "signs up user with email and password" do 
		new_user.visit_page.signup_as
		expect(page).to have_content("Welcome! You have signed up successfully")
	end
end