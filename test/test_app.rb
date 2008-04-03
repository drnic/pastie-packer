require File.dirname(__FILE__) + '/test_helper'

class TestApp < Test::Unit::TestCase
  
  def setup
  end

  def teardown
  end

  def test_pack_current_folder
    PastiePacker::API.expects(:paste).with(COMPLETE_PASTIE).returns("http://pastie.caboo.se/123456")
    folder = File.dirname(__FILE__) + "/fixtures"
    FileUtils.cd folder do
      PastiePacker.run
    end
  end
end
