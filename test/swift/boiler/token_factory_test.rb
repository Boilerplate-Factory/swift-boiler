require 'test_helper'

class Swift::Boiler::TokenFactoryTest < Minitest::Test

	def test_create_token_list()
		run_create_token_list_positive_test(VALID_TEST_PARAMETERS_ONE, VALID_TEST_PARAMETER_ONE_EXPECTED_TYPES, 1)
		run_create_token_list_positive_test(VALID_TEST_PARAMETERS_TWO, VALID_TEST_PARAMETER_TWO_EXPECTED_TYPES, 2)
		run_create_token_list_positive_test(VALID_TEST_PARAMETERS_THREE, VALID_TEST_PARAMETER_THREE_EXPECTED_TYPES, 3)
		run_create_token_list_positive_test(VALID_TEST_PARAMETERS_FOUR, VALID_TEST_PARAMETER_FOUR_EXPECTED_TYPES, 4)
		run_create_token_list_positive_test(VALID_TEST_PARAMETERS_FIVE, VALID_TEST_PARAMETER_FIVE_EXPECTED_TYPES, 5)
		INVALID_TEST_PARAMETERS_LIST.each { |parameters| run_create_token_list_negative_test(parameters) }
	end

	def run_create_token_list_negative_test(parameters)
		token_factory = Swift::Boiler::TokenFactory.new
		assert_raises { token_factory.create_token_list(parameters) }
	end

	def run_create_token_list_positive_test(parameters, expected_types, test_index)
		token_factory = Swift::Boiler::TokenFactory.new
		number_of_arguments = parameters.count
		expected_type = expected_types
		token_list = token_factory.create_token_list(parameters)
		token_list_count = token_list.count
		assert(token_list_count == number_of_arguments,  "#{test_index}: There should be a token for each argument in a list of valid arguments there are #{number_of_arguments} arguments and #{token_list_count} tokens")
		
		for index in 0...token_list_count
   			assert(expected_type[index] == token_list[index].type,  "#{test_index}: expected #{expected_type[index]} instead of #{token_list[index].type}")
		end
	end

	def test_is_valid_template_path()
		token_factory = Swift::Boiler::TokenFactory.new
		valid_instances = VALID_TEST_TEMPLATE_PATH
		invalid_instances = INVALID_TEST_TEMPLATE_PATH

		while !valid_instances.empty?
			valid_instance = valid_instances.shift
			assert(token_factory.is_valid_template_path(valid_instance), "#{valid_instance} should be a valid template path")
		end

		while !invalid_instances.empty?
			invalid_instance = invalid_instances.shift
			assert(!token_factory.is_valid_template_path(invalid_instance), "#{invalid_instance} should not be a valid template path")
		end
	end

	def test_is_valid_class_name()
		token_factory = Swift::Boiler::TokenFactory.new
		valid_instances = VALID_TEST_CLASS_NAMES
		invalid_instances = INVALID_TEST_CLASS_NAMES

		while !valid_instances.empty?
			valid_instance = valid_instances.shift
			assert(token_factory.is_valid_class_name(valid_instance), "#{valid_instance} should be a valid class name")
		end

		while !invalid_instances.empty?
			invalid_instance = invalid_instances.shift
			assert(!token_factory.is_valid_class_name(invalid_instance), "#{invalid_instance} should not be a valid class name")
		end
	end

	def test_is_valid_property()
		token_factory = Swift::Boiler::TokenFactory.new
		valid_instances = VALID_TEST_PROPERTIES
		invalid_instances = INVALID_TEST_PROPERTIES

		while !valid_instances.empty?
			valid_instance = valid_instances.shift
			assert(token_factory.is_valid_property(valid_instance), "#{valid_instance} should be a valid property")
		end

		while !invalid_instances.empty?
			invalid_instance = invalid_instances.shift
			assert(!token_factory.is_valid_property(invalid_instance), "#{invalid_instance} should not be a valid property")
		end
	end


	def test_is_valid_option()
		token_factory = Swift::Boiler::TokenFactory.new
		valid_instances = VALID_TEST_OPTIONS
		invalid_instances = INVALID_TEST_OPTIONS

		while !valid_instances.empty?
			valid_instance = valid_instances.shift
			assert(token_factory.is_valid_option(valid_instance), "#{valid_instance} should be a valid option")
		end

		while !invalid_instances.empty?
			invalid_instance = invalid_instances.shift
			assert(!token_factory.is_valid_option(invalid_instance), "#{invalid_instance} should not be a valid option")
		end
	end
end