class Hotels::SuggestionsService < Hotels::Base
  PERSONAL_ROUTE = 'suggestions'

  def initialize(params={})
    @query = params[:query]
  end

  def perform!
    @api_call = hotels

    if @api_call.include?('errors')
      error_result
    else
      ResultObjects::Success.new(@api_call)
    end
  end

private

  def hotels
    HTTParty.get("#{base_url}#{PERSONAL_ROUTE}?query=#{@query}")
  end

  def error_result
    result = ResultObjects::Failure.new('')
    result.errors = @api_call['errors']
    result
  end
end
