require 'test_helper'

class Swift::Boiler::TokenFactoryTest < Minitest::Test

  def test_create_token_list()
    valid_parameters_one = ['-t', '/Desktop/mytemplate.mustache', 'MyView', 'label:UILabel']
    valid_parameters_two = ['-t', '/Desktop/mytemplate.mustache', 'MyView', '-d', 'label:UILabel']
    valid_parameters_three = ['view', 'MyView', 'label:UILabel']
    valid_parameters_four = ['--help']
    valid_parameters_five = ['view', 'MyView', '-d', 'label:UILabel']
    invalid_parameter_list = [['-help'],['--h'], ['-t', '/Desktop/mytemplate', 'MyView', 'label:UILabel'], ['-t', '/Desktop/.mustache', 'MyView', '-d', 'label:UILabel'], ['-t', '/Desktop/mytemplate.mustache', 'MyView', '--d', 'label:UILabel'], ['view', '_MyView', 'label:UILabel'], ['view', '3MyView', '-d', 'label:UILabel'], ['view', '&MyView', '-d', 'label:UILabel']]
    expected_types_one = [Swift::Boiler::Token::OPTION, Swift::Boiler::Token::TEMPLATE_PATH, Swift::Boiler::Token::CLASS_NAME, Swift::Boiler::Token::PROPERTY]
    expected_types_two = [Swift::Boiler::Token::OPTION, Swift::Boiler::Token::TEMPLATE_PATH, Swift::Boiler::Token::CLASS_NAME, Swift::Boiler::Token::OPTION, Swift::Boiler::Token::PROPERTY]
    expected_types_three = [Swift::Boiler::Token::TEMPLATE_NAME, Swift::Boiler::Token::CLASS_NAME, Swift::Boiler::Token::PROPERTY]
    expected_types_four = [Swift::Boiler::Token::OPTION]
    expected_types_five = [Swift::Boiler::Token::TEMPLATE_NAME, Swift::Boiler::Token::CLASS_NAME, Swift::Boiler::Token::OPTION, Swift::Boiler::Token::PROPERTY]

    run_create_token_list_positive_test(valid_parameters_one, expected_types_one, 1)
    run_create_token_list_positive_test(valid_parameters_two, expected_types_two, 2)
    run_create_token_list_positive_test(valid_parameters_three, expected_types_three, 3)
    run_create_token_list_positive_test(valid_parameters_four, expected_types_four, 4)
    run_create_token_list_positive_test(valid_parameters_five, expected_types_five, 5)
    invalid_parameter_list.each { |parameters| run_create_tokens_from_arguments_negative_test(parameters) }
  end

  def run_create_tokens_from_arguments_negative_test(parameters)
    token_factory = Swift::Boiler::TokenFactory.new
    assert_raises { token_factory.create_tokens_from_arguments(parameters) }
  end

  def run_create_token_list_positive_test(parameters, expected_types, test_index)
    token_factory = Swift::Boiler::TokenFactory.new
    number_of_arguments = parameters.count
    expected_type = expected_types
    token_list = token_factory.create_tokens_from_arguments(parameters)
    token_list_count = token_list.count
    assert(token_list_count == number_of_arguments,  "#{test_index}: There should be a token for each argument in a list of valid arguments there are #{number_of_arguments} arguments and #{token_list_count} tokens")
    
    for index in 0...token_list_count
        assert(expected_type[index] == token_list[index].type,  "#{test_index}: expected #{expected_type[index]} instead of #{token_list[index].type}")
    end
  end

  def test_is_valid_template_path()
    token_factory = Swift::Boiler::TokenFactory.new
    valid_instances = ['/Users/user.name/Documents/filename.mustache', '/Users/user_name/Documents/filename.mustache', 'Users/user-name/Documents/filename.mustache', 'Users/user name/Documents/filename.mustache', '/Users/username/Documents/file_name.mustache', '/Users/username/Documents/file-name.mustache','./file-name.mustache','../../../file-name.mustache', '~/folder/file-name.mustache','/folder/.././file-name.mustache', '/Users/username/Documents/file n a me.mustache', 'C:\Program Files.mustache', 'C:\Desktop\test.mustache']
    invalid_instances = ['/Users/user.name/Documents/filename', '/Users/user_name/Documents/.mustache', '.mustache', '/folder/test.mustaches']

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
    valid_instances = ['MyClass', 'myclass', 'myClass', 'my_class', 'My_Class', 'My1Class', 'MyClass1', 'MyClass'] 
    invalid_instances = ['3MyClass', '#myclass', 'my#Class', 'my$class', 'My(Class', 'M\'Class', 'My\"Class', 'My*Class', '&MyClass', 'My^Class', 'My+Class', 'My-Class'] 

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
    valid_instances = ['property:Class', 'property:class', 'Property:Class', 'Property:class', 'p:Class', 'p:class', 'P:Class', 'P:class', 'property:Cla', 'property:cla', 'pro2perty:class', 'property:cl3ass', 'property4:class', 'property:class5', '_property:class', 'pro-perty:class', 'prop_erty:class', 'property:cl-ass', 'property:cl_ass', 'prop0erty:Class', 'property1:Class','property:C2lass']
    invalid_instances = ['property:1class', 'property:_2class', 'property:_class', '0property:class', 'property:C', 'property:c', 'property:Cl', 'property:cl', ':Class', ':class', 'property:', '::class', 'property::', 'p*Class', 'p*class', 'property*Class', 'property*class', 'property#C', 'property#c', 'Property@C', 'Property@c', 'Property&Class', 'Property&class', 'p::Class', 'p::class', 'property::Class', 'property::class', 'property::C', 'property::c', 'Prop#erty:C', 'Prope$rty:c', 'Property:Cl@ss']

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
    valid_instances = ['-o', '--opt'] 
    invalid_instances = ['o','option','opt', 'o-', '-op', '-opt', '-opti', '-optio', '-option', 'o-ption', 'op-tion', 'opt-ion', 'opti-on', 'optio-n', 'option-', '--o', 'o--', '--op', 'op--', 'o--p', 'o--pt', 'o--ption', 'op--tion', 'opt--ion', 'optio--n', 'option--', '**option', '++option', '##option', '*o', '+o', '#o']

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