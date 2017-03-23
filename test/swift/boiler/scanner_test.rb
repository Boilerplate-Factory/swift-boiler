require 'test_helper'

class Swift::Boiler::ScannerTest < Minitest::Test

	def test_create_token_list()
		scanner = Swift::Boiler::Scanner.new
		# positive tests
		assert(scanner.scan(VALID_TEST_PARAMETERS_ONE))
		assert(scanner.scan(VALID_TEST_PARAMETERS_TWO))
		assert(scanner.scan(VALID_TEST_PARAMETERS_THREE))
		assert(scanner.scan(VALID_TEST_PARAMETERS_FOUR))
		assert(scanner.scan(VALID_TEST_PARAMETERS_FIVE))

		# negative tests
		assert_raises { scanner.scan(INVALID_TEST_PARAMETERS_ONE) }
		assert_raises { scanner.scan(INVALID_TEST_PARAMETERS_TWO) }
		assert_raises { scanner.scan(INVALID_TEST_PARAMETERS_THREE) }
		assert_raises { scanner.scan(INVALID_TEST_PARAMETERS_FOUR) }
		assert_raises { scanner.scan(INVALID_TEST_PARAMETERS_FIVE) }
		INVALID_TEST_PARAMETERS_LIST.each { |parameters| assert_raises { scanner.scan(parameters) } }
	end
end