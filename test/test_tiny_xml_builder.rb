require 'test/unit'
require 'tiny_xml_builder'

class TinyXMLBuilderTest < Test::Unit::TestCase
  def setup
    @xml = TinyXml::Builder.new(:indent_size => (@indent_size = 4))
  end

  def test_passing_no_params
    assert_equal '<zaza />', "#{@xml.zaza}"
  end

  def test_passing_a_nil_as_param
    assert_equal '<zaza></zaza>', "#{@xml.zaza nil}"
  end

  def test_passing_one_param_that_is_a_hash
    assert_equal '<zaza zuzu="zyzy" />', "#{@xml.zaza :zuzu => "zyzy"}"
  end

  def test_passing_one_simple_param
    assert_equal '<zaza>123</zaza>', "#{@xml.zaza 123}"
  end

  def test_passing_an_enumerable
    assert_equal "<zaza>1</zaza>\n<zaza>2</zaza>", "#{@xml.zaza 1..2}"
  end

  def test_passing_multiple_params
    assert_equal "<zaza>1</zaza>\n<zaza>A</zaza>\n<zaza>Z</zaza>", "#{@xml.zaza 1, "A", :Z}"
  end

  def test_passing_a_simple_param_and_a_hash
    assert_equal '<zaza zuzu="zumzum">123</zaza>', "#{@xml.zaza 123, :zuzu => "zumzum"}"
  end

  def test_passing_two_simple_params_and_a_hash
    assert_equal %Q|<zaza zuzu="zumzum">123</zaza>\n<zaza zuzu="zumzum">456</zaza>|, 
      "#{@xml.zaza 123, 456, :zuzu => "zumzum"}"
  end

  def test_pushing_xml_directly
    content = '<foo>bar</foo>'
    @xml << content
    assert_equal content, @xml.to_s
  end

  def test_passing_a_block
    @xml.zuzu(:where => 'Hawaii') {
      whatToDo {
        swim "a lot"
        justLayOnTheBeach
        party { |p|
          p.allNightLong "hoorayyyy", :must_do_this => true
        }
      }
    }
    expects = <<-EOS.strip
#{' ' * (0 * @indent_size)}<zuzu where="Hawaii">
#{' ' * (1 * @indent_size)}<whatToDo>
#{' ' * (2 * @indent_size)}<swim>a lot</swim>
#{' ' * (2 * @indent_size)}<justLayOnTheBeach />
#{' ' * (2 * @indent_size)}<party>
#{' ' * (3 * @indent_size)}<allNightLong must_do_this="true">hoorayyyy</allNightLong>
#{' ' * (2 * @indent_size)}</party>
#{' ' * (1 * @indent_size)}</whatToDo>
#{' ' * (0 * @indent_size)}</zuzu>
    EOS
    assert_equal expects, "#{@xml}"
  end
end
