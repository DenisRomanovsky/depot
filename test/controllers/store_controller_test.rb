require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#main .entry', 3, message = "Number of products is incorrect."
    assert_select 'h3', 'Programming Ruby 1.9', message = "No Programming Ruby found in the page."
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

  test "should display prices with dollar"  do
    get :index
    assert_select '.price', /\$[,\d]+\.\d\d/, message = "The prices are displayed with incorrect format. "
  end

end

