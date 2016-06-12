class Hotels::CreateService < Hotels::Base
  PERSONAL_ROUTE = 'hotels'

  def initialize(params={})
    @params = params
    @data = @params[:data]
  end

  def perform!
    @api_call = create_hotel

    if @api_call.include?('errors')
      error_result
    else
      ResultObjects::Success.new(@api_call)
    end
  end

private

  def create_hotel
    HTTParty.post("#{base_url}#{PERSONAL_ROUTE}",
      body: @data.to_json,
      headers: { 'Content-Type' => 'application/json' } )
  end

  def error_result
    result = ResultObjects::Failure.new('')
    result.errors = @api_call['errors']
    result
  end
end
