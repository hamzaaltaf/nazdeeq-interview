feature "home page" do 
	it "shows Tasker App" do 
		visit('/')
		expect(page).to have_content("Tasker App")
	end
end 