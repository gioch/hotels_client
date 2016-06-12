class HotelsController < ApplicationController
  def index
    response = HTTParty.get('https://evening-cliffs-68697.herokuapp.com/api/hotels')

    render json: response
    # @hotels = [1,2,3]
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
