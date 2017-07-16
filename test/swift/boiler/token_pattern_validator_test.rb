require 'test_helper'

class Swift::Boiler::TokenPatternValidatorTest < Minitest::Test

  def test_validate_token_list()
    validator = Swift::Boiler::TokenPatternValidator.new

    # option only pattern
    option_only_pattern_token_list = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-h')]
    assert(validator.validate(option_only_pattern_token_list), 'a list with only one option should be valid')

    # template path pattern
    valid_template_path_pattern_one= [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-t'), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    valid_template_path_pattern_two = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-t'), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    valid_template_path_pattern_three = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-t'), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    assert(validator.validate(valid_template_path_pattern_one), 'a list with template path pattern should be valid')
    assert(validator.validate(valid_template_path_pattern_two), 'a list with template path pattern should be valid')
    assert(validator.validate(valid_template_path_pattern_three), 'a list with template path pattern should be valid')

    # template name pattern
    template_path_pattern_token_list_one = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    template_path_pattern_token_list_two = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    template_path_pattern_token_list_three = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    assert(validator.validate(template_path_pattern_token_list_one), 'a list with template name pattern should be valid')
    assert(validator.validate(template_path_pattern_token_list_two), 'a list with template name pattern should be valid')
    assert(validator.validate(template_path_pattern_token_list_three), 'a list with template name pattern should be valid')

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

    assert(!validator.validate(bad_pattern_token_list_one), 'a list with only options should not be valid')
    assert(!validator.validate(bad_pattern_token_list_two), 'a template pattern not starting with option should not be valid')
    assert(!validator.validate(bad_pattern_token_list_three), 'a list with multiple template path should not be valid')
    assert(!validator.validate(bad_pattern_token_list_four), 'a list with multiple template names should not be valid')
    assert(!validator.validate(bad_pattern_token_list_five), 'a list with multiple class names should not be valid')
    assert(!validator.validate(bad_pattern_token_list_six), 'a list with only a tempalte name should not be valid')
    assert(!validator.validate(bad_pattern_token_list_seven), 'a list with only a tempalte path should not be valid')
    assert(!validator.validate(bad_pattern_token_list_eight), 'a list with only a class name should not be valid')
    assert(!validator.validate(bad_pattern_token_list_nine), 'a list with only a property should not be valid')
    assert(!validator.validate(bad_pattern_token_list_ten), 'a empty list should not be valid')
  end

  def test_is_token_pattern_valid()
    validator = Swift::Boiler::TokenPatternValidator.new
    valid_token_list_one = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-h')]
    valid_token_list_two = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    valid_token_list_three = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    valid_token_list_four = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    valid_token_list_five = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-t'), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    valid_token_list_six = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-t'), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    valid_token_list_seven = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-t'), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    invalid_token_list_one = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'')]
    invalid_token_list_two = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    invalid_token_list_three = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,'')]
    invalid_token_list_four = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,'')]
    invalid_token_list_five = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    invalid_token_list_six = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,'')]
    invalid_token_list_seven = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,'')]
    invalid_token_list_eight = [Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    invalid_token_list_nine = [Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    invalid_token_list_ten = []
    assert(validator.is_token_pattern_valid(valid_token_list_one))
    assert(validator.is_token_pattern_valid(valid_token_list_two))
    assert(validator.is_token_pattern_valid(valid_token_list_three))
    assert(validator.is_token_pattern_valid(valid_token_list_four))
    assert(validator.is_token_pattern_valid(valid_token_list_five))
    assert(validator.is_token_pattern_valid(valid_token_list_six))
    assert(validator.is_token_pattern_valid(valid_token_list_seven))
    assert(!validator.is_token_pattern_valid(invalid_token_list_one))
    assert(!validator.is_token_pattern_valid(invalid_token_list_two))
    assert(!validator.is_token_pattern_valid(invalid_token_list_three))
    assert(!validator.is_token_pattern_valid(invalid_token_list_four))
    assert(!validator.is_token_pattern_valid(invalid_token_list_five))
    assert(!validator.is_token_pattern_valid(invalid_token_list_six))
    assert(!validator.is_token_pattern_valid(invalid_token_list_seven))
    assert(!validator.is_token_pattern_valid(invalid_token_list_eight))
    assert(!validator.is_token_pattern_valid(invalid_token_list_nine))
    assert(!validator.is_token_pattern_valid(invalid_token_list_ten))
  end

  def test_has_template_path_pattern()
    validator = Swift::Boiler::TokenPatternValidator.new
    valid_instance_one = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-t'), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    valid_instance_two = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-t'), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    valid_instance_three = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-t'), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    invalid_instance_one = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-h'), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    invalid_instance_two = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    invalid_instance_three = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-t'), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    invalid_instance_four = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-t'), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,'')]
    assert(validator.is_template_path_pattern(valid_instance_one))
    assert(validator.is_template_path_pattern(valid_instance_two))
    assert(validator.is_template_path_pattern(valid_instance_three))
    assert(!validator.is_template_path_pattern(invalid_instance_one))
    assert(!validator.is_template_path_pattern(invalid_instance_two))
    assert(!validator.is_template_path_pattern(invalid_instance_three))
    assert(!validator.is_template_path_pattern(invalid_instance_four))
  end

  def test_has_template_name_pattern()  
    validator = Swift::Boiler::TokenPatternValidator.new  
    valid_instance_one = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    valid_instance_two = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    valid_instance_three = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,''), Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,''),Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY,'')]
    invalid_instance_one = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-t'), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    invalid_instance_two = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_PATH,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    invalid_instance_three = [Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME,''), Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME,'')]
    invalid_instance_four = []
    assert(validator.is_template_name_pattern(valid_instance_one))
    assert(validator.is_template_name_pattern(valid_instance_two))
    assert(validator.is_template_name_pattern(valid_instance_three))
    assert(!validator.is_template_name_pattern(invalid_instance_one))
    assert(!validator.is_template_name_pattern(invalid_instance_two))
    assert(!validator.is_template_name_pattern(invalid_instance_three))
    assert(!validator.is_template_name_pattern(invalid_instance_four))
    
  end

  def test_has_option_only_pattern() 
    validator = Swift::Boiler::TokenPatternValidator.new
    valid_help_token_list_one = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-h')]
    valid_help_token_list_two = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'--help')]
    invalid_help_token_list_one = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-help')]
    invalid_help_token_list_two = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'--h')]
    invalid_help_token_list_three = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-t')]
    invalid_help_token_list_four = [Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-h'), Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION,'-h')]
    assert(validator.is_help_pattern(valid_help_token_list_one))
    assert(validator.is_help_pattern(valid_help_token_list_two))
    assert(!validator.is_help_pattern(invalid_help_token_list_one))
    assert(!validator.is_help_pattern(invalid_help_token_list_two))
    assert(!validator.is_help_pattern(invalid_help_token_list_three))
    assert(!validator.is_help_pattern(invalid_help_token_list_four))
  end

end