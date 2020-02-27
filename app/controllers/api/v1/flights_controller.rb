# frozen_string_literal: true

class Api::V1::FlightsController < ApiController
  before_action :authenticate_user!
  # skip_before_action :verify_authenticity_token, :except => [:update, :create]
  # protect_from_forgery with: :null_session, only: [:update, :create]
  # before_action :set_rating, only:[:show, :update]
  #
  # def index
  #   @ratings = current_user.ratings
  #   render json: @ratings.map(&:to_h), status: :ok
  # end
  #
  # def show
  #   render json: @rating.to_h
  # end
  #
  def create
    @rating = current_user.ratings.new(rating_params)
    if @rating.save
      render json: @rating.to_h
    else
      render json: { errors: @rating.errors }, status: :unprocessable_entity
    end
  end
  #
  # def update
  #   if @rating.present?
  #     if @rating.update(rating_params)
  #       render json: @rating.to_h
  #     else
  #       render json: { errors: @rating.errors }, status: :unprocessable_entity
  #     end
  #   else
  #     render json: { errors: "Couldn't find Rating" }, status: :unprocessable_entity
  #   end
  # end
  #
  # private
  #
  #   def set_rating
  #     @rating = current_user.ratings.find_by_id(params[:id])
  #   end
  #
  #   def rating_params
  #     params.permit(:score, :kombucha_id)
  #   end

end
