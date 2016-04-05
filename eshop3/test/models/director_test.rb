require 'test_helper'

class DirectorTest < ActiveSupport::TestCase
  def test_name
    director = Director.create(:first_name => 'Joel',:last_name => 'Spolsky')
    assert_equal 'Joel Spolsky', director.name
  end
end
