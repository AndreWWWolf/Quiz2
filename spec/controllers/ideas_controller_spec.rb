require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    def current_user
        @current_user ||= FactoryBot.create(:user)
    end

    describe "#new" do
        context 'with user signed in' do 
            before do
                session[:user_id] = current_user.id
            end

            it 'renders the new page' do
                get :new
                expect(response).to render_template :new
            end

            it 'instatiates @idea variable' do
                get :new
                expect(assigns(:idea)).to be_a_new(Idea)
            end
        end

        context 'with no user signed in' do
            it 'redirects the user to the log in page' do
                get :new
                expect(response).to redirect_to(new_session_path)
            end

            it 'flashes an alert message' do
                get :new
                expect(flash[:alert]).to be
            end
        end
    end

    describe "#create" do
        context 'with user signed in' do
            before do
                session[:user_id] = current_user.id
            end

            context 'with valid params' do
                it 'saves the idea in the db' do
                    before_count = Idea.all.count
                    post :create, params: {idea: FactoryBot.attributes_for(:idea)}
                    after_count = Idea.all.count
                    expect(after_count).to eq(before_count + 1)
                end

                it 'redirects to the idea show page' do
                    post :create, params: {idea: FactoryBot.attributes_for(:idea)}
                    expect(response).to redirect_to(Idea.last)
                end

                it 'associates the idea and the current_user' do
                    post :create, params: {idea: FactoryBot.attributes_for(:idea)}
                    expect(Idea.last.user).to eq(current_user)
                end
            end

            context 'with invalid params' do 
                it 'renders the new idea page' do
                    post :create, params: {idea: FactoryBot.attributes_for(:idea, title: nil)}
                    expect(response).to render_template :new
                end
            end
        end

        context 'with no user signed in' do
            it 'redirects the user to the sign in page' do
                post :create, params: {idea: FactoryBot.attributes_for(:idea)}
                expect(response).to redirect_to(new_session_path)
            end
        end
    end

end
