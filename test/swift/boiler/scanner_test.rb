require 'test_helper'

class Swift::Boiler::ScannerTest < Minitest::Test

	def test_create_token_list()
		scanner = Swift::Boiler::Scanner.new

		valid_test_parameters_one = ['-t', '/Desktop/mytemplate.mustache', 'MyView', 'label:UILabel']
		valid_test_parameters_two = ['-t', '/Desktop/mytemplate.mustache', 'MyView', '-d', 'label:UILabel']
		valid_test_parameters_three = ['view', 'MyView', 'label:UILabel']
		valid_test_parameters_four = ['--help']
		valid_test_parameters_five = ['view', 'MyView', '-d', 'label:UILabel']
		assert(scanner.scan(valid_test_parameters_one))
		assert(scanner.scan(valid_test_parameters_two))
		assert(scanner.scan(valid_test_parameters_three))
		assert(scanner.scan(valid_test_parameters_four))
		assert(scanner.scan(valid_test_parameters_five))

		invalid_test_parameters_one = ['-t', '/Desktop/mytemplate.mustache', 'view', 'MyView', 'label:UILabel']
		invalid_test_parameters_two = ['-t', '/Desktop/mytemplate.mustache', '../mytemplate.mustache', 'MyView', '-d', 'label:UILabel']
		invalid_test_parameters_three = ['view', 'MyView', 'OneMoreView', 'label:UILabel']
		invalid_test_parameters_four = ['--help', '-d']
		invalid_test_parameters_five = ['view', 'view', 'MyView', '-d', 'label:UILabel']
		invalid_test_parameters_list = [['-help'],['--h'], ['-t', '/Desktop/mytemplate', 'MyView', 'label:UILabel'], ['-t', '/Desktop/.mustache', 'MyView', '-d', 'label:UILabel'], ['-t', '/Desktop/mytemplate.mustache', 'MyView', '--d', 'label:UILabel'], ['view', '_MyView', 'label:UILabel'], ['view', '3MyView', '-d', 'label:UILabel'], ['view', '&MyView', '-d', 'label:UILabel']]
		assert_raises { scanner.scan(invalid_test_parameters_one) }
		assert_raises { scanner.scan(invalid_test_parameters_two) }
		assert_raises { scanner.scan(invalid_test_parameters_three) }
		assert_raises { scanner.scan(invalid_test_parameters_four) }
		assert_raises { scanner.scan(invalid_test_parameters_five) }
		invalid_test_parameters_list.each { |parameters| assert_raises { scanner.scan(parameters) } }
	end
end