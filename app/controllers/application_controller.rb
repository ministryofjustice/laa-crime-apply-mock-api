class ApplicationController < ActionController::API
  def message
    render json: { name: "Welcome to Mock API" }
  end
end
