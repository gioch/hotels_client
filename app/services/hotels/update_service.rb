class Hotels::UpdateService < Hotels::Base
  PERSONAL_ROUTE = 'hotels'

  def initialize(params={})
    @params = params
    @data = @params[:data]
    @id = @params[:id]
  end

  def perform!
    @api_call = update_hotel

    if @api_call.include?('errors')
      error_result
    else
      ResultObjects::Success.new(@api_call)
    end
  end

private

  def update_hotel
    HTTParty.put("#{base_url}#{PERSONAL_ROUTE}/#{@id}",
      body: @data.to_json,
      headers: { 'Content-Type' => 'application/json' } )
  end

  def error_result
    result = ResultObjects::Failure.new('')
    result.errors = @api_call['errors']
    result
  end
end
