class NewTaskForm
    include Capybara::DSL
    
    def visit_page
        click_on("Create New Task")
        self
    end
    
    def fill_in_with(params = {})
        fill_in('Name', with: params.fetch(:name, 'Default Task'))
        fill_in('Description', with: 'A good task indeed !')
        select('Public', from: 'Privacy')
        self
    end
    
    def submit
        click_link_or_button('create_task')
        # click_on("Create Task")
        self
    end
    
end