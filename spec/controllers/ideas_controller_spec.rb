require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

    describe '#new' do
        it 'render new template' do
            get(:new)
            expect(response).to(render_template(:new))
        end

        it 'sets an instance variable with new job posts' do
            get(:new)
            expect(assigns(:idea)).to(be_a_new(Idea))
        end
    end #new

    describe '#create' do
        def valid_request
            post(:create, params:{idea: FactoryBot.attributes_for(:idea)})
        end
    context 'with calid params' do
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
        
    end #create
end
