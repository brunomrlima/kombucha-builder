class Api::V1::FlightsController < ApiController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, :except => [:update, :create]
  protect_from_forgery with: :null_session, only: [:create]
  #
  def index
    @flights = Flight.all
    render json: @flights.map(&:to_h), status: :ok
  end

  def show
    @flight = Flight.find_by_id(params[:id])
    render json: @flight.to_h
  end

  def create
    selected_score = flight_params[:score]
    selected_kombucha = Kombucha.find_by_id(flight_params[:kombucha_id])
    if selected_kombucha.present?
      kombuchas_samples_ids = Kombucha.n_samples_with_different_base(3, selected_score, selected_kombucha)
    else
      kombuchas_samples_ids = Kombucha.n_samples_with_different_base(4, selected_score)
    end
    puts kombuchas_samples_ids
    if kombuchas_samples_ids.length == 4
      flight = Flight.new(name: "Kombuchas #{kombuchas_samples_ids}")
      if flight.save
        kombuchas_samples_ids.each do |kombucha_id|
          flight.flight_items.create(kombucha_id: kombucha_id)
        end
        render json: flight.to_h
      else
        render json: { errors: flight.errors }, status: :unprocessable_entity
      end
    else
      render json: { errors: "Not possible with the parameters used" }, status: :unprocessable_entity
    end
  end

  private

    def flight_params
      params.permit(:kombucha_id, :score)
    end

end
