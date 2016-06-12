require 'rails_helper'

describe HotelsController, type: :controller do
  context 'stubbed api calls' do
    before(:each) do
      # Stubs needed but i did not implemented it.
      # Takes longer to run specs but its ok for this example task

      # allow(controller).to receive(Hotels::SuggestionsService).and_return(true)
    end

    describe 'GET #suggestions' do
      it 'should call correct service' do
        expect_any_instance_of(Hotels::SuggestionsService)
          .to receive(:perform!).and_call_original

        get :suggestions
      end
    end

    describe 'GET #index' do
      it 'should call correct service' do
        expect_any_instance_of(Hotels::ListService)
          .to receive(:perform!)
          .and_return(ResultObjects::Success.new([hotel_data_hash]))

        get :index
      end

      it 'should render correct partial' do
        get :index

        expect(response).to render_template(:index)
      end
    end

    describe 'POST #create' do
      context 'with correct data' do
        context 'with live(unstubbed) service' do
          it 'should call original service' do
            expect_any_instance_of(Hotels::CreateService)
              .to receive(:perform!).and_call_original

            post :create, params: correct_create_payload
          end
        end

        context 'with stubbed service call' do
          before(:each) do
            expect_any_instance_of(Hotels::CreateService)
              .to receive(:perform!)
              .and_return(ResultObjects::Success.new(hotel_data_hash))
          end

          it 'should redirect to created hotels page' do
            post :create, params: correct_create_payload

            expect(response).to redirect_to(hotels_path)
          end
        end
      end

      context 'with incorrect data' do
        before(:each) do
          expect_any_instance_of(Hotels::CreateService)
            .to receive(:perform!)
            .and_return(ResultObjects::Failure.new(hotel_validation_errors))
        end

        it 'should render template with staff creation form' do
          post :create, params: incorrect_create_payload

          expect(response).to render_template(:new)
        end
      end
    end

    describe 'GET #show' do
      it 'should render show page' do
        expect_any_instance_of(Hotels::GetService)
          .to receive(:perform!)
          .and_return(ResultObjects::Success.new(hotel_data_hash))

        get :show, params: { id: hotel_data_hash[:id] }

        expect(response).to render_template(:show)
      end
    end

    describe 'GET #edit' do
      context 'with correct data' do
        it 'should redirect to created hotels page' do
          expect_any_instance_of(Hotels::GetService)
            .to receive(:perform!)
            .and_return(ResultObjects::Success.new(hotel_data_hash))

          put :update, params: { id: hotel_data_hash[:id] }

          expect(response).to render_template(:edit)
        end
      end
    end

    # describe 'PUT #update' do
    #   context 'with correct data' do
    #     it 'should call correct services' do
    #       expect_any_instance_of(Staffs::Update)
    #         .to receive(:perform!).and_return(ResultObjects::Success.new(staff))
    #
    #       put :update, params: correct_update_payload
    #     end
    #
    #     it 'should assign @staff' do
    #       put :update, params: correct_update_payload
    #
    #       expect(assigns(:staff)).not_to be_nil
    #     end
    #
    #     it 'should redirect to updated staff page' do
    #       put :update, params: correct_update_payload
    #
    #       expect(response).to redirect_to(staffs_path)
    #     end
    #
    #     it 'should have correct flash message' do
    #       put :update, params: correct_update_payload
    #
    #       expect(flash[:success]).to be_present
    #       expect(flash[:success]).to eq(I18n.t('updated_successfully'))
    #     end
    #   end
    #
    #   context 'with incorrect data' do
    #     it 'should call correct services' do
    #       expect_any_instance_of(Staffs::Update)
    #         .to receive(:perform!).and_return(ResultObjects::Failure.new(staff))
    #
    #       put :update, params: incorrect_update_payload
    #     end
    #
    #     it 'should render template with staff edit form' do
    #       put :update, params: incorrect_update_payload
    #
    #       expect(response).to render_template(:edit)
    #     end
    #
    #     it 'should have correct flash message' do
    #       put :update, params: incorrect_update_payload
    #
    #       expect(flash[:alert]).to be_present
    #       expect(flash[:alert]).to eq(I18n.t('fill_fields_correctly'))
    #     end
    #   end
    # end

    # describe 'DELETE #destroy' do
    #   it 'should delete record' do
    #     new_staff = create(:staff)
    #
    #     expect { delete :destroy, params: { id: new_staff.id } }
    #       .to change { Staff.count }.by(-1)
    #   end
    #
    #   it 'should redirect to staffs page' do
    #     new_staff = create(:staff)
    #
    #     delete :destroy, params: { id: new_staff.id }
    #
    #     expect(response).to redirect_to(staffs_path)
    #   end
    # end
  end

  context 'before actions' do
    it { is_expected.not_to execute_before_action :set_hotel,
      on: :index, via: :get }

    it { is_expected.not_to execute_before_action :set_hotel,
      on: :new, via: :get }

    it { is_expected.not_to execute_before_action :set_hotel,
      on: :create, via: :post, with: { id: 1 }  }

    it { is_expected.to execute_before_action :set_hotel,
      on: :show, via: :get, with: { id: 1 }  }

    it { is_expected.to execute_before_action :set_hotel,
      on: :edit, via: :get, with: { id: 1 }  }

    it { is_expected.to execute_before_action :set_hotel,
      on: :update, via: :put, with: { id: 1 }  }

    it { is_expected.to execute_before_action :set_hotel,
      on: :destroy, via: :delete, with: { id: 1 }  }
  end

private

  def correct_create_payload
    {
      hotel: {
        name: FactoryGirl.generate(:name),
        address: FactoryGirl.generate(:address),
        star_rating: FactoryGirl.generate(:star_rating),
        accomodation_type_id: FactoryGirl.generate(:accomodation_type_id),
      }
    }
  end

  def correct_edit_payload
    correct_create_payload.merge(id: FactoryGirl.generate(:id))
  end

  def incorrect_create_payload
    {
      hotel: {
        name: FactoryGirl.generate(:name),
        address: FactoryGirl.generate(:address),
        star_rating: FactoryGirl.generate(:star_rating),
      }
    }
  end

  def hotel_data_hash
    {
      id: FactoryGirl.generate(:id),
      name: FactoryGirl.generate(:name),
      address: FactoryGirl.generate(:address),
      star_rating: FactoryGirl.generate(:star_rating),
      accomodation_type: {
        id: FactoryGirl.generate(:id),
        name: FactoryGirl.generate(:name)
      }
    }
  end

  def hotel_validation_errors
    { errors: ['error'] }
  end

  def parse_response
    JSON.parse(response.body)
  end
end
