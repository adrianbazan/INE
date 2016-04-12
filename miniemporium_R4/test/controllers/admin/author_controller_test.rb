require File.dirname(__FILE__) + '/../../test_helper'  

class Admin::AuthorControllerTest < ActionController::TestCase
  fixtures :authors

  test "new" do
    get :new  
    assert_template 'admin/author/new'  
    assert_tag 'h1', :content => 'Create new author'  
    assert_tag 'form', :attributes => { :action => '/admin/author/create' }   
  end  

  test "create" do
    get :new    
    assert_template 'admin/author/new'
    assert_difference(Author, :count) do
      post :create, :author => {:first_name => 'Joel', :last_name => 'Spolsky'}
      assert_response :redirect
      assert_redirected_to :action => 'index'      
    end
    assert_equal 'Author Joel Spolsky was succesfully created.', flash[:notice]
  end

  test "failing_create" do
    assert_no_difference(Author, :count) do
      post :create, :author => {:first_name => 'Joel'}
      assert_response :success
      assert_template 'admin/author/new'
      assert_tag :tag => 'div', :attributes => {:class => 'field_with_errors'}
    end
  end

  test "edit" do
    get :edit, :id => 1
    assert_tag :tag => 'input', :attributes => { :name => 'author[first_name]', :value => 'Joel' }
    assert_tag :tag => 'input', :attributes => { :name => 'author[last_name]', :value => 'Spolsky' }
  end

  test "update" do
    post :update, :id => 1, :author => { :first_name => 'Joseph', :last_name => 'Spolsky' }
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
    assert_equal 'Joseph', Author.find(1).first_name
  end

  test "test_destroy" do
    assert_difference(Author, :count, -1) do
      post :destroy, :id => 1
      assert_equal flash[:notice], 'Succesfully deleted author Joel Spolsky.'
      assert_response :redirect
      assert_redirected_to :action => 'index'
      get :index
      assert_response :success
      assert_tag :tag => 'div', :attributes => {:id => 'notice'},
        :content => 'Succesfully deleted author Joel Spolsky.'
    end
  end

  test "show" do
    get :show, :id => 1
    assert_template 'admin/author/show'
    assert_equal 'Joel', assigns(:author).first_name
    assert_equal 'Spolsky', assigns(:author).last_name
    assert_tag "h1", :content => Author.find(1).name
  end

  test "index" do
    get :index
    assert_response :success
    assert_tag :tag => 'table', :children => { :count => Author.count + 1, :only => {:tag => 'tr'} }
    Author.find_each do |a|
      assert_tag :tag => 'td', :content => a.name
    end
  end
end
