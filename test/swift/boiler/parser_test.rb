require 'test_helper'

class Swift::Boiler::ParserTest < Minitest::Test

  def test_get_property_from_token()
    parser = Swift::Boiler::Parser.new
    firstToken = Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY, "label:UILabel")
    property = parser.get_property_from_token(firstToken)
    assert(property[:name] == "label")
    assert(property[:type] == "UILabel")
    assert(property[:capitalized_name] == "Label")
  end

  def test_get_property_name_from_token()
    parser = Swift::Boiler::Parser.new
    firstToken = Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY, "label:UILabel")
    assert(parser.get_property_name_from_token(firstToken) == "label")

    secondToken = Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY, "MyView:UIView")
    assert(parser.get_property_name_from_token(secondToken) == "myView")
  end

  def test_get_property_type_from_token()
    parser = Swift::Boiler::Parser.new
    firstToken = Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY, "label:UILabel")
    assert(parser.get_property_type_from_token(firstToken) == "UILabel")

    secondToken = Swift::Boiler::Token.new(Swift::Boiler::Token::PROPERTY, "view:MyView")
    assert(parser.get_property_type_from_token(secondToken) == "MyView")
  end

  def test_downcase_name()
    parser = Swift::Boiler::Parser.new
    assert(parser.downcase_name("MyTableViewCell") == "myTableViewCell")
    assert(parser.downcase_name("M") == "m")
    assert(parser.downcase_name("View") == "view")
  end

  def test_capitalize_name()
    parser = Swift::Boiler::Parser.new
    assert(parser.capitalize_name("tableViewCell") == "TableViewCell")
    assert(parser.capitalize_name("m") == "M")
    assert(parser.capitalize_name("view") == "View")
  end

  def test_get_name_from_abreviation()
    parser = Swift::Boiler::Parser.new
    assert(parser.get_name_from_abreviation("tableviewcell") == "table_view_cell")
    assert(parser.get_name_from_abreviation("m") == "model")
    assert(parser.get_name_from_abreviation("v") == "view")
    assert(parser.get_name_from_abreviation("c") == "controller")
    assert(parser.get_name_from_abreviation("s") == "singleton")
    assert(parser.get_name_from_abreviation("tvc") == "table_view_cell")
    assert(!parser.get_name_from_abreviation("notAnOption"))
  end

  def test_is_protocol_token()
    parser = Swift::Boiler::Parser.new
    assert(parser.is_protocol_token(Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION, "-p")))
    assert(parser.is_protocol_token(Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION, "--protocol")))
    assert(parser.is_protocol_token(Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION, "-p")))
    assert(parser.is_protocol_token(Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION, "--protocol")))
    assert(!parser.is_protocol_token(Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION, "--p")))
    assert(!parser.is_protocol_token(Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION, "-protocol")))
    assert(!parser.is_protocol_token(Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION, "--notTheProtocol")))
    assert(!parser.is_protocol_token(Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION, "-b")))
    assert(!parser.is_protocol_token(Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME, "-p")))
    assert(!parser.is_protocol_token(Swift::Boiler::Token.new(Swift::Boiler::Token::CLASS_NAME, "--protocol")))
  end

  def test_is_abreviation()
    parser = Swift::Boiler::Parser.new
    assert(parser.is_abreviation(Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME, "tableviewcell")))
    assert(parser.is_abreviation(Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME, "m")))
    assert(parser.is_abreviation(Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME, "v")))
    assert(parser.is_abreviation(Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME, "c")))
    assert(parser.is_abreviation(Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME, "s")))
    assert(parser.is_abreviation(Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME, "c")))
    assert(parser.is_abreviation(Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME, "tvc")))
    assert(!parser.is_abreviation(Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME, "notAnOption")))
    assert(!parser.is_abreviation(Swift::Boiler::Token.new(Swift::Boiler::Token::OPTION, "tvc")))
  end

  def test_get_name_from_name_token()
    parser = Swift::Boiler::Parser.new
    name = "Name!!"
    token = Swift::Boiler::Token.new(Swift::Boiler::Token::TEMPLATE_NAME, name)
    assert(parser.get_name_from_name_token(token) == name.downcase, "Did not get the expected name from the name token!")
  end

end