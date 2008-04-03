require File.dirname(__FILE__) + '/test_helper'

class TestApp < Test::Unit::TestCase
  attr_reader :target_folder

  def setup
    @target_folder = File.dirname(__FILE__) + "/unpack"
    FileUtils.mkdir_p target_folder
  end

  def teardown
    FileUtils.rm_rf target_folder
  end

  def test_pack_current_folder
    folder = File.dirname(__FILE__) + "/fixtures"
    FileUtils.cd folder do
      PastiePacker.run
    end
  end

  def test_unpack_within_current_folder
    PastiePacker.any_instance.expects(:fetch_pastie).with("http://pastie.caboo.se/123456").
      returns($complete_pastie)
    FileUtils.cd target_folder do
      PastiePacker.run("http://pastie.caboo.se/123456")
    end
  end

  def test_unpack_within_current_folder_raw_txt
    PastiePacker.any_instance.expects(:fetch_pastie).with("http://pastie.caboo.se/123456").
      returns($complete_pastie)
    FileUtils.cd target_folder do
      PastiePacker.run("http://pastie.caboo.se/123456.txt")
    end
  end
end
