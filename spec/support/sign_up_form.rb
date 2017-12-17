class SignUpForm
	include Capybara::DSL

	def visit_page
		visit('/users/sign_up')
		self
	end

	def signup_as
		fill_in("Email", with: 'hamza@gmail.com')
		fill_in("Password", with: 'password')
		fill_in("Password confirmation", with: 'password')
		click_on("Sign up")
		 sleep 4
		self
	end
end