require 'test_helper'

class ProducerTest < ActiveSupport::TestCase

  fixtures :producers

  test "failing_create" do
  	producer = Producer.new
	assert_equal false, producer.save
	assert_equal 2, producer.errors.count
        assert producer.errors[:name]
  end

  test "create" do
    	producer = Producer.new(
			:name => 'Paco')
    	assert producer.save
	assert_equal 'Paco', producer.name
  end

end
