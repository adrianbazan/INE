require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActionDispatch::IntegrationTest

  def setup
  end

  test "user_account" do
    george = new_session_as(:george)
    user_account = george.creates_user_account(:user => { :name => 'George Smith', :login => 'george',
                                               :email => 'george@emporium.com', :password => 'gold',
                                               :password_confirmation => 'gold' })
    george.shows_user_account user_account
    george.edits_user_account(user_account, :user => { :name => 'George Jackson', :login => 'george',
                                            :email => 'george@emporium.com', :password => 'silver',
                                            :password_confirmation => 'silver' })
  end

  private

  module BrowsingTestDSL
    include ERB::Util
    attr_writer :name

    def creates_user_account(parameters)
      user_name = parameters[:user][:name]
      get '/user/new'
      assert_response :success
      assert_template 'user/new'
      assert_tag :tag => 'h1', :content => 'Create new account'
      assert_tag :tag => 'input', :attributes => { :id => 'user_name' }
      post '/user/create', parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'user/show'
      assert_tag :tag => 'h1', :content => "#{user_name}"
      assert_equal flash[:notice], "Account #{user_name} was succesfully created. User logged in."
      assert_tag :tag => 'div', :attributes => { :id => 'notice' },
                                :content => "Account #{user_name} was succesfully created. User logged in."
      assert_tag :tag => 'dt', :content => 'Name'
      assert_tag :tag => 'dd', :content => user_name
      return User.find_by_login(parameters[:user][:login])
    end

    def shows_user_account(user_account)
      get "/user/show/?id=#{user_account.id}"
      assert_response :success
      assert_template 'user/show'
      assert_tag :tag => 'h1', :content => user_account.name
      assert_tag :tag => 'dt', :content => 'Name'
      assert_tag :tag => 'dd', :content => user_account.name
    end

    def edits_user_account(user_account, parameters)
      user = User.find_by_id(user_account.id)
      get "/user/edit?id=#{user.id}"
      assert_response :success
      assert_template 'user/edit'
      assert_tag :tag => 'h1', :content => 'Edit account'
      assert_tag :tag => 'input', :attributes => { :id => 'user_name' }
      post '/user/update', parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'user/show'
      user_name = parameters[:user][:name]
      assert_tag :tag => 'h1', :content => user_name
      assert_equal flash[:notice], "Account #{user_name} was succesfully updated."
      assert_tag :tag => 'div', :attributes => { :id => 'notice' },
                                :content => "Account #{user_name} was succesfully updated."      
      assert_tag :tag => 'dt', :content => 'Name'
      assert_tag :tag => 'dd', :content => user_name
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(BrowsingTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
