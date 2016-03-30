require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
fixtures :authors
#comprobar tb que no se repiten los datos
def test_author
	author = Author.create(:dni => '35879759Y',
				:firstname => 'jose',
				:surnames => 'perez',
				:birthdate => '2000-01-20')
	assert_equal '35879759Y jose perez 2000-01-20',author.information
end


end
