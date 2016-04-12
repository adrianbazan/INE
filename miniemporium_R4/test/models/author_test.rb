require File.dirname(__FILE__) + '/../test_helper'

class AuthorTest < ActiveSupport::TestCase
  test "test_name" do
    author = Author.create(:first_name => 'Joel', :last_name => 'Spolsky')
    assert_equal 'Joel Spolsky', author.name
  end
end
