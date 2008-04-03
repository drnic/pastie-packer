require File.dirname(__FILE__) + '/test_helper.rb'

class TestConversion < Test::Unit::TestCase
  attr_reader :base_folder, :unpack_folder

  def setup
    @base_folder    = File.dirname(__FILE__) + "/fixtures"
    @unpack_folder  = File.dirname(__FILE__) + "/unpacked"
  end

  def teardown
    FileUtils.rm_rf unpack_folder
  end

  def test_pack_complete_folder_structure
    packed_folder = PastiePacker.new.path_to_string base_folder
    assert_equal($complete_pastie, packed_folder)
  end

  def test_unpack_complete_folder_structure
    folder = PastiePacker.new.unpack($complete_pastie, unpack_folder)
    assert_equal(unpack_folder, folder)
    diff = `diff -ur #{base_folder} #{unpack_folder}`
    assert_equal("", diff)
  end

end
