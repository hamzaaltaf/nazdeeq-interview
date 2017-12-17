require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  #authenticated user
  describe "authenticated user" do
    let(:user) {FactoryBot.create(:user)}
    let(:user2) {FactoryBot.create(:user)}
    before do 
      sign_in(user)
    end 
    context "if user is owner of the task" do 
      let (:task) {FactoryBot.create(:public_task, name: 'New Name Task', user: user)}
      describe "delete action" do 
        it "destroys the item from database" do 
          xhr :delete, :destroy, id: task
          expect(Task.exists?(task.id)).to be_falsy
        end
      end

      describe ":update  action" do
        context "valid data" do 
          let (:valid_task) {FactoryBot.create(:public_task, name: 'New Name Task1', user: user)}
          it "updates the complete attribute of task" do
            before = valid_task.complete
            xhr :put, :update, params: {id: task, task: valid_task}
            valid_task.reload
            expect(assigns(:task).complete).to eq(true)
          end
        end

        context "invalid data" do 
          let (:invalid_task) {FactoryBot.create(:public_task, name: '')}
          it "raises validation exception" do
            expect {xhr :put, :update, params: {id: task, task: invalid_task}}.to raise_error(ActiveRecord::RecordInvalid)
            # expect(response).to render_template(:edit)
          end
        end
      end
    end

    context "if user is not owner of the task" do 
      before do 
        sign_in(user)
      end
      describe ":update  action" do
        let (:task) {FactoryBot.create(:public_task, name: 'New Name Task', user: user2)}
        it " renders tasks page" do
          put :update, params: {id: task, task: task}, xhr: true
          expect(assigns(:task)).to be_nil
        end
      end
  end

    #action SHOW
    describe ":show action" do
      let(:task) {FactoryBot.create(:public_task, user: user)}
      it "renders the template show" do
       get :show, params: { id: task.id}
       expect(response).to render_template(:show)
     end

     it "assigns the task to @task" do
       get :show, params: { id: task.id}
       expect(assigns(:task)).to eq(task) 
     end
   end

    #action INDEX
    describe "GET #index" do
      it "returns http success" do
        xhr :get, :index
        expect(response).to have_http_status(:success)
      end

      it "serves the index template" do
        xhr :get, :index
        expect(response).to render_template(:index)
      end

      it "shows only the public tasks" do
        public_task = FactoryBot.create(:public_task, user: user)
        private_task = FactoryBot.create(:task, user: user2)
        xhr :get, :index
        puts "here are tasks #{:tasks} and the public_task #{public_task.inspect}"
        expect(assigns(:tasks)).to match_array([public_task])
      end
    end
    #action NEW
    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
      it "assigns the Task.new to @task" do
        get :new
        expect(assigns(:task)).to be_a_new(Task) 
      end
    end
    
    #action CREATE
    describe ":create  action" do
      let (:valid_task) {FactoryBot.attributes_for(:public_task, name: 'Another Task', user: user)}
      let (:invalid_task) {FactoryBot.attributes_for(:public_task, name: '', user: user)}
      context "valid data" do 
        
        it "creates data in database" do
          expect {
            xhr :post, :create, params: {task: valid_task}
            }.to change(Task, :count).by(1)
          end
        end
        context "invalid data" do 
          it " renders new again" do
            expect {
            xhr :post, :create, params: {task: invalid_task}
            }.to change(Task, :count).by(0)
          end
        end
      end
    end

  #####################################################################
  ####################### Un-authenticated USER #######################
  #####################################################################
  describe "Un-authenticated user" do
    let(:user) {FactoryBot.create(:user)}
    
    #action SHOW
    describe ":show action" do
      let(:task) {FactoryBot.create(:public_task, user: user)}
      it "renders the template show" do
       get :show, params: { id: task.id}
       expect(response).to render_template(:show)
     end

     it "assigns the task to @task" do
       get :show, params: { id: task.id}
       expect(assigns(:task)).to eq(task) 
     end
   end
    #action INDEX
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "serves the index template" do
        get :index
        expect(response).to render_template(:index)
      end

      it "shows only the public tasks" do
        public_task = FactoryBot.create(:public_task, user: user)
        private_task = FactoryBot.create(:task, name: 'A different name', user: user)
        get :index
        expect(assigns(:tasks)).to match_array([public_task])
      end
    end
    #action NEW
    describe "GET #new" do
      it "it redirects to the login" do
        get :new
        expect(response).to redirect_to(new_user_session_url)
      end
    end
    #action CREATE
    describe ":create  action" do
      let (:valid_task) {FactoryBot.attributes_for(:public_task, name: 'Another Task', user: user)}
      let (:invalid_task) {FactoryBot.attributes_for(:public_task, name: '', user: user)}

      it "redirects to login_screen" do
        post :create, params: {task: valid_task}
          # expect(response).to redirect_to(task_path(assigns(:task)))
          expect(response).to redirect_to(new_user_session_url)
        end
      end
    #action UPDATE
    describe ":update  action" do
      let (:task) {FactoryBot.create(:public_task, name: 'New Name Task', user: user)}
      it " renders login page" do
        put :update, params: {id: task, task: task}
          # expect(response).to render_template(:edit)
          expect(response).to redirect_to(new_user_session_url)
        end
      end
    #action EDIT
    describe "GET #edit" do
      let(:task) {FactoryBot.create(:public_task, user: user)}
      it "renders login page" do
        get :edit, params: {id: task.id}
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end
