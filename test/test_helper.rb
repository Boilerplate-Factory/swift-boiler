$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'swift/boiler'
require 'swift/boiler/builder'
require 'swift/boiler/scanner'
require 'swift/boiler/parser'
require 'swift/boiler/template'
require 'swift/boiler/token'
require 'minitest/autorun'
require 'swift/boiler/token_factory'
require 'swift/boiler/validator'


VALID_TEST_PROPERTIES = ['property:Class', 'property:class', 'Property:Class', 'Property:class', 'p:Class', 'p:class', 'P:Class', 'P:class', 'property:Cla', 'property:cla', 'pro2perty:class', 'property:cl3ass', 'property4:class', 'property:class5', '_property:class', 'pro-perty:class', 'prop_erty:class', 'property:cl-ass', 'property:cl_ass', 'prop0erty:Class', 'property1:Class','property:C2lass']
INVALID_TEST_PROPERTIES = ['property:1class', 'property:_2class', 'property:_class', '0property:class', 'property:C', 'property:c', 'property:Cl', 'property:cl', ':Class', ':class', 'property:', '::class', 'property::', 'p*Class', 'p*class', 'property*Class', 'property*class', 'property#C', 'property#c', 'Property@C', 'Property@c', 'Property&Class', 'Property&class', 'p::Class', 'p::class', 'property::Class', 'property::class', 'property::C', 'property::c', 'Prop#erty:C', 'Prope$rty:c', 'Property:Cl@ss']

VALID_TEST_OPTIONS = ['-o', '--opt'] 
INVALID_TEST_OPTIONS = ['o','option','opt', 'o-', '-op', '-opt', '-opti', '-optio', '-option', 'o-ption', 'op-tion', 'opt-ion', 'opti-on', 'optio-n', 'option-', '--o', 'o--', '--op', 'op--', 'o--p', 'o--pt', 'o--ption', 'op--tion', 'opt--ion', 'optio--n', 'option--', '**option', '++option', '##option', '*o', '+o', '#o']

VALID_TEST_CLASS_NAMES = ['MyClass', 'myclass', 'myClass', 'my_class', 'My_Class', 'My1Class', 'MyClass1', 'MyClass'] 
INVALID_TEST_CLASS_NAMES = ['3MyClass', '#myclass', 'my#Class', 'my$class', 'My(Class', 'M\'Class', 'My\"Class', 'My*Class', '&MyClass', 'My^Class', 'My+Class', 'My-Class'] 

VALID_TEST_TEMPLATE_PATH = ['/Users/user.name/Documents/filename.mustache', '/Users/user_name/Documents/filename.mustache', 'Users/user-name/Documents/filename.mustache', 'Users/user name/Documents/filename.mustache', '/Users/username/Documents/file_name.mustache', '/Users/username/Documents/file-name.mustache','./file-name.mustache','../../../file-name.mustache', '~/folder/file-name.mustache','/folder/.././file-name.mustache', '/Users/username/Documents/file n a me.mustache', 'C:\Program Files.mustache', 'C:\Desktop\test.mustache']
INVALID_TEST_TEMPLATE_PATH = ['/Users/user.name/Documents/filename', '/Users/user_name/Documents/.mustache', '.mustache', '/folder/test.mustaches']

VALID_TEST_PARAMETERS_ONE = ['-t', '/Desktop/mytemplate.mustache', 'MyView', 'label:UILabel']
VALID_TEST_PARAMETERS_TWO = ['-t', '/Desktop/mytemplate.mustache', 'MyView', '-d', 'label:UILabel']
VALID_TEST_PARAMETERS_THREE = ['view', 'MyView', 'label:UILabel']
VALID_TEST_PARAMETERS_FOUR = ['--help']
VALID_TEST_PARAMETERS_FIVE = ['view', 'MyView', '-d', 'label:UILabel']

INVALID_TEST_PARAMETERS_ONE = ['-t', '/Desktop/mytemplate.mustache', 'view', 'MyView', 'label:UILabel']
INVALID_TEST_PARAMETERS_TWO = ['-t', '/Desktop/mytemplate.mustache', '../mytemplate.mustache', 'MyView', '-d', 'label:UILabel']
INVALID_TEST_PARAMETERS_THREE = ['view', 'MyView', 'OneMoreView', 'label:UILabel']
INVALID_TEST_PARAMETERS_FOUR = ['--help', '-d']
INVALID_TEST_PARAMETERS_FIVE = ['view', 'view', 'MyView', '-d', 'label:UILabel']
INVALID_TEST_PARAMETERS_LIST = [['-help'],['--h'], ['-t', '/Desktop/mytemplate', 'MyView', 'label:UILabel'], ['-t', '/Desktop/.mustache', 'MyView', '-d', 'label:UILabel'], ['-t', '/Desktop/mytemplate.mustache', 'MyView', '--d', 'label:UILabel'], ['view', '_MyView', 'label:UILabel'], ['view', '3MyView', '-d', 'label:UILabel'], ['view', '&MyView', '-d', 'label:UILabel']]

VALID_TEST_PARAMETER_ONE_EXPECTED_TYPES = [Swift::Boiler::Token::OPTION, Swift::Boiler::Token::TEMPLATE_PATH, Swift::Boiler::Token::CLASS_NAME, Swift::Boiler::Token::PROPERTY]
VALID_TEST_PARAMETER_TWO_EXPECTED_TYPES = [Swift::Boiler::Token::OPTION, Swift::Boiler::Token::TEMPLATE_PATH, Swift::Boiler::Token::CLASS_NAME, Swift::Boiler::Token::OPTION, Swift::Boiler::Token::PROPERTY]
VALID_TEST_PARAMETER_THREE_EXPECTED_TYPES = [Swift::Boiler::Token::TEMPLATE_NAME, Swift::Boiler::Token::CLASS_NAME, Swift::Boiler::Token::PROPERTY]
VALID_TEST_PARAMETER_FOUR_EXPECTED_TYPES = [Swift::Boiler::Token::OPTION]
VALID_TEST_PARAMETER_FIVE_EXPECTED_TYPES = [Swift::Boiler::Token::TEMPLATE_NAME, Swift::Boiler::Token::CLASS_NAME, Swift::Boiler::Token::OPTION, Swift::Boiler::Token::PROPERTY]

