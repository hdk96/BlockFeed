require 'test_helper'

class ArticleCategoryControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get article_category_new_url
    assert_response :success
  end

  test "should get create" do
    get article_category_create_url
    assert_response :success
  end

end
