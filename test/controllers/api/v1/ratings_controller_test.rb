require 'test_helper'

class Api::V1::RatingsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @rating = ratings(:rating_one)
    @kombucha = kombuchas(:pork_pop)
    @user = @rating.user
  end

  test "index should work" do
    get '/api/v1/ratings', params: {}, headers: headers
    assert_response :success
  end

  test "returns user's ratings" do
    get '/api/v1/ratings', params: {}, headers: headers
    assert_equal response_body.length, @user.ratings.count
  end

  test "shows one user's ratings" do
    get "/api/v1/ratings/#{@rating.id}", headers: headers
    assert_equal response_body['id'], @rating.id
  end

  test "creates a new rating" do
    post "/api/v1/ratings", params: rating_params, headers: headers
    assert_response :success
    assert_not_nil Rating.find(response_body['id'])
  end

  test "does not create rating if kombucha is invalid" do
    post "/api/v1/ratings", params: invalid_rating_params, headers: headers
    assert_response :unprocessable_entity
    assert_not_nil response_body['errors']
  end

  test "updates rating" do
    patch "/api/v1/ratings/#{@rating.id}", params: rating_params, headers: headers
    assert_response :success
    @rating.reload
    assert_equal rating_params[:kombucha_id], @rating.kombucha_id
  end

  test "does not update rating if kombucha is invalid" do
    patch "/api/v1/ratings/#{@rating.id}", params: invalid_rating_params, headers: headers
    assert_response :unprocessable_entity
    assert_not_nil response_body['errors']
  end

  def response_body
    @json ||= JSON.parse(@response.body)
  end

  def headers
    { "HTTP_USER_ID": @user.id }
  end

  def rating_params
    {
      score: 1,
      user_id: @rating.user_id,
      kombucha_id: @kombucha.id
    }
  end

  def invalid_rating_params
    {
      score: 7,
      user_id: @rating.user_id,
      kombucha_id: 12345
    }
  end
end
