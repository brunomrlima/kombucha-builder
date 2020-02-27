require 'test_helper'

class Api::V1::RatingsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @rating = ratings(:rating_one)
    @kombucha = kombuchas(:pork_pop)
  end

  test "index should work" do
    get '/api/v1/ratings', params: {}, headers: headers
    assert_response :success
  end
  #
  # test "returns collection of kombuchas" do
  #   get '/api/v1/kombuchas', params: {}, headers: headers
  #   assert_equal response_body.length, Kombucha.count
  # end
  #
  # test "shows one kombucha" do
  #   get "/api/v1/kombuchas/#{@kombucha.id}", headers: headers
  #   assert_equal response_body['id'], @kombucha.id
  # end
  #
  test "creates a new rating" do
    post "/api/v1/ratings", params: rating_params, headers: headers
    assert_response :success
    assert_not_nil Rating.find(response_body['id'])
  end
  #
  # test "does not create kombucha if fizziness level is invalid" do
  #   post "/api/v1/kombuchas", params: invalid_kombucha_params, headers: headers
  #   assert_response :unprocessable_entity
  #   assert_not_nil response_body['errors']
  # end
  #
  # test "updates a kombucha" do
  #   patch "/api/v1/kombuchas/#{@kombucha.id}", params: kombucha_params, headers: headers
  #   assert_response :success
  #   @kombucha.reload
  #   assert_equal kombucha_params[:kombucha][:name], @kombucha.name
  # end
  #
  # test "does not update kombucha if fizziness level is invalid" do
  #   patch "/api/v1/kombuchas/#{@kombucha.id}", params: invalid_kombucha_params, headers: headers
  #   assert_response :unprocessable_entity
  #   assert_not_nil response_body['errors']
  # end
  #
  def response_body
    @json ||= JSON.parse(@response.body)
  end

  def headers
    user = users(:first_user)
    { "HTTP_USER_ID": user.id }
  end
  #
  def rating_params
    {
      score: 1,
      user_id: @rating.user_id,
      kombucha_id: @kombucha.id
    }
  end
  #
  # def invalid_kombucha_params
  #   {
  #     kombucha: {
  #       name: "New Name",
  #       fizziness_level: "flat"
  #     }
  #   }
  # end
end
