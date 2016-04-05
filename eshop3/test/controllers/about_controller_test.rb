require File.dirname(__FILE__) + '/../test_helper'

class AboutControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_response :success
    assert_template 'about/index'
    assert_equal 'Sobre Crazy Films', assigns(:page_title)
    assert_tag 'title', :content => 'Sobre Crazy Films'
  end
end
