class ApiLogsController < ApplicationController
  def index
    @api_logs = ApiLog.all
    render json: @api_logs
  end

  def search
    @api_logs = ApiLog.where(
      :$or => [
        { endpoint: /#{params[:query]}/i },
        { request_method: /#{params[:query]}/i },
        { params: /#{params[:query]}/i },
        { response_code: params[:query].to_i }
      ]
    )
    render json: @api_logs
  end
end