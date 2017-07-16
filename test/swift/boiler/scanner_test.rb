require 'test_helper'

class Swift::Boiler::ScannerTest < Minitest::Test

  def test_create_token_list()
    scanner = Swift::Boiler::Scanner.new

    valid_test_parameters = [['-t', '/Desktop/mytemplate.mustache', 'MyView', 'label:UILabel'], 
    ['-t', '/Desktop/mytemplate.mustache', 'MyView', '-d', 'label:UILabel'], 
    ['view', 'MyView', 'label:UILabel'], ['--help'], 
    ['view', 'MyView', '-d', 'label:UILabel'],
    ['view', 'MyView', 'test:UIView']]

    invalid_test_parameters = [['-help'], ['--h'], ['--help', '-d'],
    ['-t', '/Desktop/mytemplate', 'MyView', 'label:UILabel'], 
    ['-t', '/Desktop/.mustache', 'MyView', '-d', 'label:UILabel'], 
    ['-t', '/Desktop/mytemplate.mustache', 'MyView', '--d', 'label:UILabel'], 
    ['view', '_MyView', 'label:UILabel'], ['view', '3MyView', '-d', 'label:UILabel'], 
    ['view', '&MyView', '-d', 'label:UILabel'],
    ['-t', '/Desktop/mytemplate.mustache', 'view', 'MyView', 'label:UILabel'],
    ['-t', '/Desktop/mytemplate.mustache', '../mytemplate.mustache', 'MyView', '-d', 'label:UILabel'],
    ['view', 'MyView', 'OneMoreView', 'label:UILabel'],
    ['view', 'view', 'MyView', '-d', 'label:UILabel']]

    valid_test_parameters.each { |parameters| 
        assert(scanner.create_valid_token_pattern_from_arguments(parameters)) 
    }

    invalid_test_parameters.each { |parameters| assert_raises { 
        scanner.create_valid_token_pattern_from_arguments(parameters) } 
    }
  end
end