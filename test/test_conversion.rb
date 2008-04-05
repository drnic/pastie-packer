require File.dirname(__FILE__) + '/test_helper.rb'

class TestConversion < Test::Unit::TestCase
  attr_reader :base_folder, :unpack_folder, :pastie

  def setup
    @base_folder    = File.dirname(__FILE__) + "/fixtures/sample_app"
    @unpack_folder  = File.dirname(__FILE__) + "/unpacked"
    @pastie = PastiePacker.new
  end

  def teardown
    FileUtils.rm_rf unpack_folder
  end

  def test_pack_complete_folder_structure
    packed_folder = pastie.path_to_string base_folder
    assert_equal($complete_pastie, packed_folder)
  end

  def test_unpack_complete_folder_structure
    pastie.contents = $complete_pastie
    folder = pastie.unpack(unpack_folder)
    assert_equal(unpack_folder, folder)
    diff = `diff -ur #{base_folder} #{unpack_folder}`
    assert_equal("", diff)
  end

end
