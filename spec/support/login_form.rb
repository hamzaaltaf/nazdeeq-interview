class LoginForm
	include Capybara::DSL

	def visit_page
		visit('/users/sign_in')
		self
	end

	# def login_as(user)
	# 	puts "this is user #{user.inspect}"
	# 	fill_in("Email", with: user.email)
	# 	fill_in("Password", with: user.password)
	# 	click_on("Log in")
	# 	 sleep 4
	# 	self
	# end
end