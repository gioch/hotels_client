class HotelsController < ApplicationController
  before_action :set_hotel, except: [:index, :new, :create]

  def suggestions
    query = params[:query] || ''

    suggestions = HTTParty.get('https://evening-cliffs-68697.herokuapp.com/api/suggestions?query=' + query)

    render json: suggestions
  end

  def index
    query = params[:query] || ''

    @hotels = HTTParty.get('https://evening-cliffs-68697.herokuapp.com/api/hotels?query=' + query)
  end

  def new
    @accomodation_types = accomodations
  end

  def create
    result = HTTParty.post('https://evening-cliffs-68697.herokuapp.com/api/hotels',
            body: hotel_params.to_json,
            headers: { 'Content-Type' => 'application/json' } )

    if result['errors'].present?
      @accomodation_types = accomodations
      @errors = result['errors']
      render 'new'
    else
      redirect_to hotels_path
    end
  end

  def show
  end

  def edit
    @accomodation_types = accomodations
  end

  def update
    result = HTTParty.put('https://evening-cliffs-68697.herokuapp.com/api/hotels/' + params[:id],
            body: hotel_params.to_json,
            headers: { 'Content-Type' => 'application/json' } )

    if result['errors'].present?
      @accomodation_types = accomodations
      @errors = result['errors']
      render 'edit'
    else
      redirect_to hotels_path
    end
  end

  def destroy
    result = HTTParty.delete('https://evening-cliffs-68697.herokuapp.com/api/hotels/' + params[:id])

    if result['errors'].present?
      flash[:alert] = result['errors'].first
    end

    redirect_to hotels_path
  end

private

  def accomodations
    HTTParty.get('https://evening-cliffs-68697.herokuapp.com/api/accomodation_types')
  end

  def set_hotel
    @hotel = HTTParty.get('https://evening-cliffs-68697.herokuapp.com/api/hotels/' + params[:id])
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
