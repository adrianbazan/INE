require 'test_helper'

class DirectorTest < ActiveSupport::TestCase
  fixtures :directors

  def failing_create
  	director = Director.new
	assert_equal false, director.save
	assert_equal 2, director.errors.count
  end

  def create
    	director = Director.create(
			:first_name => 'Paco',
			:last_name => 'Alvarez')
    	
	assert_equal 'Paco Alvarez', director.name
  end
end
