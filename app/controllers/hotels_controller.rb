class HotelsController < ApplicationController
  before_action :set_hotel, except: [:index, :new, :create]

  def suggestions
    result = Hotels::SuggestionsService.new(query: search_query).perform!

    render json: result.data
  end

  def index
    result = Hotels::ListService.new(query: search_query).perform!

    @hotels = result.data
  end

  def new
    @accomodation_types = accomodations
  end

  def create
    result = Hotels::CreateService.new(data: hotel_params).perform!

    if result.success?
      redirect_to hotels_path
    else
      @accomodation_types = accomodations
      @errors = result.errors
      render 'new'
    end
  end

  def show
  end

  def edit
    @accomodation_types = accomodations
  end

  def update
    result = Hotels::UpdateService.new(id:  params[:id], data: hotel_params).perform!

    if result.success?
      redirect_to hotels_path
    else
      @accomodation_types = accomodations
      @errors = result.errors
      render 'edit'
    end
  end

  def destroy
    result = Hotels::DeleteService.new(id: params[:id]).perform!

    if result.failure?
      flash[:alert] = result.errors
    end

    redirect_to hotels_path
  end

private

  def search_query
    params[:query] || ''
  end

  def accomodations
    result = Hotels::AccomodationsService.new.perform!
    result.data
  end

  def set_hotel
    result = Hotels::GetService.new(id: params[:id]).perform!

    if result.success?
      @hotel = result.data
    else
      flash[:alert] = result.errors
      redirect_to hotels_path
    end
  end

  def hotel_params
    {
      hotel: {
        name: params[:name],
        address: params[:address],
        star_rating: params[:star_rating],
        accomodation_type_id: params[:accomodation_type_id]
      }
    }
  end
end
