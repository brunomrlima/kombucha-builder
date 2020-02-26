# frozen_string_literal: true

class ApiController < ApplicationController
  protected
    def current_user
      # USER-ID == HTTP_USER_ID to work with Postman
      @user ||= User.find(request.headers["USER-ID"]) if request.headers["USER-ID"]
    end

    def authenticate_user!
      unless current_user.present?
        render json: { error: "Authentication failed." }, status: :unprocessable_entity
      end
    end
end
