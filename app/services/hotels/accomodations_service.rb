class Hotels::AccomodationsService < Hotels::Base
  PERSONAL_ROUTE = 'accomodation_types'

  def initialize(params={})
    @params = params
  end

  def perform!
    @api_call = accomodations

    if @api_call.include?('errors')
      error_result
    else
      ResultObjects::Success.new(@api_call)
    end
  end

private

  def accomodations
    HTTParty.get("#{base_url}#{PERSONAL_ROUTE}")
  end

  def error_result
    result = ResultObjects::Failure.new('')
    result.errors = @api_call['errors']
    result
  end
end
