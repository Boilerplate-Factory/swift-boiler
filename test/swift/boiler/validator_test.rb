require 'test_helper'

class Swift::Boiler::ValidatorTest < Minitest::Test

	def test_validate_token_list()
		validator = Swift::Boiler::Validator.new

		# option only pattern
		option_only_pattern_token_list = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'')]
		assert(validator.validate_token_list(option_only_pattern_token_list), 'a list with only one option show be valid')

		# template path pattern
		template_path_pattern_token_list_one = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
		template_path_pattern_token_list_two = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
		template_path_pattern_token_list_three = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
		assert(validator.validate_token_list(template_path_pattern_token_list_one), 'a list with tempalte path pattern should be valid')
		assert(validator.validate_token_list(template_path_pattern_token_list_two), 'a list with tempalte path pattern should be valid')
		assert(validator.validate_token_list(template_path_pattern_token_list_three), 'a list with tempalte path pattern should be valid')

		# template name pattern
		template_path_pattern_token_list_one = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
		template_path_pattern_token_list_two = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
		template_path_pattern_token_list_three = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
		assert(validator.validate_token_list(template_path_pattern_token_list_one), 'a list with tempalte name pattern should be valid')
		assert(validator.validate_token_list(template_path_pattern_token_list_two), 'a list with tempalte name pattern should be valid')
		assert(validator.validate_token_list(template_path_pattern_token_list_three), 'a list with tempalte name pattern should be valid')

		# bad patterns
		bad_pattern_token_list_one = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'')]
		bad_pattern_token_list_two = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
		bad_pattern_token_list_three = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,'')]
		bad_pattern_token_list_four = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,'')]
		bad_pattern_token_list_five = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
		bad_pattern_token_list_six = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,'')]
		bad_pattern_token_list_seven = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,'')]
		bad_pattern_token_list_eight = [Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
		bad_pattern_token_list_nine = [Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
		bad_pattern_token_list_ten = []

		assert(!validator.validate_token_list(bad_pattern_token_list_one), 'a list with only options should not be valid')
		assert(!validator.validate_token_list(bad_pattern_token_list_two), 'a template pattern not starting with option should not be valid')
		assert(!validator.validate_token_list(bad_pattern_token_list_three), 'a list with multiple template path should not be valid')
		assert(!validator.validate_token_list(bad_pattern_token_list_four), 'a list with multiple template names should not be valid')
		assert(!validator.validate_token_list(bad_pattern_token_list_five), 'a list with multiple class names should not be valid')
		assert(!validator.validate_token_list(bad_pattern_token_list_six), 'a list with only a tempalte name should not be valid')
		assert(!validator.validate_token_list(bad_pattern_token_list_seven), 'a list with only a tempalte path should not be valid')
		assert(!validator.validate_token_list(bad_pattern_token_list_eight), 'a list with only a class name should not be valid')
		assert(!validator.validate_token_list(bad_pattern_token_list_nine), 'a list with only a property should not be valid')
		assert(!validator.validate_token_list(bad_pattern_token_list_ten), 'a empty list should not be valid')
	end

	def test_is_token_list_valid()
		# is_token_list_valid(list_count, is_first_element_option_type, has_template_name, has_template_path, has_class_name)
		validator = Swift::Boiler::Validator.new
		assert(validator.is_token_list_valid(34, true, false, true, true))	
		assert(validator.is_token_list_valid(30, false, true, false, true))
		assert(validator.is_token_list_valid(10, false, true, false, true))
		assert(validator.is_token_list_valid(1, true, false, false, false))
		assert(validator.is_token_list_valid(1, true, true, false, true))

		assert(!validator.is_token_list_valid(2, true, false, false, false))
		assert(!validator.is_token_list_valid(1, true, true, true, true))
		assert(!validator.is_token_list_valid(1, true, true, true, false))
		assert(!validator.is_token_list_valid(1, true, true, false, false))
		assert(!validator.is_token_list_valid(1, true, false, true, false))
		assert(!validator.is_token_list_valid(1, true, false, false, true))
		assert(!validator.is_token_list_valid(1, false, true, true, true))
		assert(!validator.is_token_list_valid(1, false, true, true, false))
		assert(!validator.is_token_list_valid(1, false, true, false, false))
		assert(!validator.is_token_list_valid(1, false, false, true, true))
		assert(!validator.is_token_list_valid(1, false, false, true, false))
		assert(!validator.is_token_list_valid(1, false, false, false, true))
		assert(!validator.is_token_list_valid(1, false, false, false, false))
	end

	def test_has_template_path_pattern()
		# has_template_path_pattern(is_first_element_option_type, has_template_name, has_template_path, has_class_name)
		validator = Swift::Boiler::Validator.new
		assert(validator.has_template_path_pattern(true, false, true, true))	

		assert(!validator.has_template_path_pattern(true, true, true, true))
		assert(!validator.has_template_path_pattern(true, true, true, false))
		assert(!validator.has_template_path_pattern(true, true, false, true))
		assert(!validator.has_template_path_pattern(true, true, false, false))
		assert(!validator.has_template_path_pattern(true, false, true, false))
		assert(!validator.has_template_path_pattern(true, false, false, true))
		assert(!validator.has_template_path_pattern(true, false, false, false))
		assert(!validator.has_template_path_pattern(false, true, true, true))
		assert(!validator.has_template_path_pattern(false, true, true, false))
		assert(!validator.has_template_path_pattern(false, true, false, true))
		assert(!validator.has_template_path_pattern(false, true, false, false))
		assert(!validator.has_template_path_pattern(false, false, true, true))
		assert(!validator.has_template_path_pattern(false, false, true, false))
		assert(!validator.has_template_path_pattern(false, false, false, true))
		assert(!validator.has_template_path_pattern(false, false, false, false))
	end

	def test_has_template_name_pattern()
		# has_template_name_pattern(is_first_element_option_type, has_template_name, has_template_path, has_class_name)
		validator = Swift::Boiler::Validator.new
		assert(validator.has_template_name_pattern(false, true, false, true))
		assert(validator.has_template_name_pattern(true, true, false, true))

		assert(!validator.has_template_name_pattern(true, true, true, true))
		assert(!validator.has_template_name_pattern(true, true, true, false))
		assert(!validator.has_template_name_pattern(true, true, false, false))
		assert(!validator.has_template_name_pattern(true, false, true, true))
		assert(!validator.has_template_name_pattern(true, false, true, false))
		assert(!validator.has_template_name_pattern(true, false, false, true))
		assert(!validator.has_template_name_pattern(true, false, false, false))
		assert(!validator.has_template_name_pattern(false, true, true, true))
		assert(!validator.has_template_name_pattern(false, true, true, false))
		assert(!validator.has_template_name_pattern(false, true, false, false))
		assert(!validator.has_template_name_pattern(false, false, true, true))
		assert(!validator.has_template_name_pattern(false, false, true, false))
		assert(!validator.has_template_name_pattern(false, false, false, true))
		assert(!validator.has_template_name_pattern(false, false, false, false))
	end

	def test_has_option_only_pattern() 
		# has_option_only_pattern(list_count, is_first_element_option_type, has_template_name, has_template_path, has_class_name)
		validator = Swift::Boiler::Validator.new
		assert(validator.has_option_only_pattern(1, true, false, false, false))

		assert(!validator.has_option_only_pattern(1, true, true, true, true))
		assert(!validator.has_option_only_pattern(1, true, true, true, false))
		assert(!validator.has_option_only_pattern(1, true, true, false, true))
		assert(!validator.has_option_only_pattern(1, true, true, false, false))
		assert(!validator.has_option_only_pattern(1, true, false, true, true))
		assert(!validator.has_option_only_pattern(1, true, false, true, false))
		assert(!validator.has_option_only_pattern(1, true, false, false, true))
		assert(!validator.has_option_only_pattern(1, false, true, true, true))
		assert(!validator.has_option_only_pattern(1, false, true, true, false))
		assert(!validator.has_option_only_pattern(1, false, true, false, false))
		assert(!validator.has_option_only_pattern(1, false, false, true, true))
		assert(!validator.has_option_only_pattern(1, false, false, true, false))
		assert(!validator.has_option_only_pattern(1, false, false, false, true))
		assert(!validator.has_option_only_pattern(1, false, false, false, false))
		assert(!validator.has_option_only_pattern(2, true, false, false, false))
		assert(!validator.has_option_only_pattern(0, true, false, false, false))
		assert(!validator.has_option_only_pattern(0, true, true, false, true))
		assert(!validator.has_option_only_pattern(2, true, false, true, true))
		assert(!validator.has_option_only_pattern(0, false, true, true, false))
		assert(!validator.has_option_only_pattern(2, false, true, true, true))
	end
end