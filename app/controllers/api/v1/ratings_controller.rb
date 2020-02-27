# frozen_string_literal: true

class Api::V1::RatingsController < ApiController
  before_action :authenticate_user!
  # before_action :set_rating, only: [:show, :update]

  def index
    @ratings = current_user.ratings
    render json: @ratings.map(&:to_h), status: :ok
  end

  # def show
  #   render json: @kombucha.to_h
  # end

  # def create
  #   @kombucha = Kombucha.new(kombucha_params)
  #
  #   if @kombucha.save
  #     render json: @kombucha.to_h
  #   else
  #     render json: { errors: @kombucha.errors }, status: :unprocessable_entity
  #   end
  # end
  #
  # def update
  #   if @kombucha.update(kombucha_params)
  #     render json: @kombucha.to_h
  #   else
  #     render json: { errors: @kombucha.errors }, status: :unprocessable_entity
  #   end
  # end
  #
  # private
  #   def set_rating
  #     @rating = Rating.find(params[:id])
  #   end
  #
  #   def kombucha_params
  #     params.require(:kombucha).permit(:name, :fizziness_level)
  #   end
  #
  #   def get_filter_params
  #     params.permit(:fizziness_level, :caffeine_free, :vegan)
  #   end
end
