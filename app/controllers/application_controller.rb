class ApplicationController < ActionController::API
  def log_action
    ApiLog.create(endpoint: request.path, request_method: request.method,
                  params: params, response_code: response.status)
  end
end
