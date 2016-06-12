class Hotels::DeleteService < Hotels::Base
  PERSONAL_ROUTE = 'hotels'

  def initialize(params={})
    @id = params[:id]
  end

  def perform!
    @api_call = delete_hotel

    if @api_call.include?('errors')
      error_result
    else
      ResultObjects::Success.new(@api_call)
    end
  end

private

  def delete_hotel
    HTTParty.delete("#{base_url}#{PERSONAL_ROUTE}/#{@id}")
  end

  def error_result
    result = ResultObjects::Failure.new('')
    result.errors = @api_call['errors']
    result
  end
end
