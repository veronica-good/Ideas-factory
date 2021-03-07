require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
let(:current_user) { FactoryBot.create(:user) }

    describe '#new' do
        context 'with signed in user' do            
            before do 
                session[:user_id] = current_user.id 
            end
            it 'render new template' do
                get(:new)
                expect(response).to(render_template(:new))
            end

            it 'sets an instance variable with new idea' do
                get(:new)
                expect(assigns(:idea)).to(be_a_new(Idea))
            end

        end#user signed in
        context "without user signed in" do 
            it "redirects to the sign in page" do 
              get :new 
              expect(response).to redirect_to(new_session_path)
            end
        end
    end #new

    describe '#create' do
        def valid_request
            post(:create, params:{idea: FactoryBot.attributes_for(:idea)})
        end
        context 'with user signed in' do
            before do 
                session[:user_id] = current_user.id 
            end
            context 'with valid params' do
                it 'creates idea in the database' do
                        count_before = Idea.count
                        valid_request
                        count_after=Idea.count
                        expect(count_after).to(eq(count_before + 1))
                    end
        
                    it 'redirects us to a show page of that idea' do
                        valid_request
                        idea=Idea.last
                        expect(response).to(redirect_to(idea_url(idea.id)))
                    end
            end #valid params
            context 'with invalid params' do
                def invalid_request
                    post(:create, params:{idea: FactoryBot.attributes_for(:idea, title: nil)})
                end
        
                it 'doesnot save a record in the database'do
                            count_before = Idea.count
                            invalid_request
                            count_after = Idea.count
                            expect(count_after).to(eq(count_before))
                end
                it 'renders the new template' do
                    # Given
                    # when
                    invalid_request
                    #then
                    expect(response).to render_template(:new)
                end
            end#invalid params
        end#user signed in
        context 'with user not signed in'do
            it 'should redirect to sign in page' do
                valid_request
                expect(response).to redirect_to(new_session_path)
            end
        end
        
    end #create
end
