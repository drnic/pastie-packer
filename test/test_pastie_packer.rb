require File.dirname(__FILE__) + '/test_helper.rb'

class TestPastiePacker < Test::Unit::TestCase
  attr_reader :base_folder

  COMPLETE_PASTIE = <<-EOS
## README.txt
This is the readme.txt

## lib/myapp.rb
class Myapp
  
end
EOS

  def setup
    @base_folder = File.dirname(__FILE__) + "/fixtures"
  end
  
  def test_pack_complete_folder_structure
    packed_folder = PastiePacker.path_to_string base_folder
    assert_equal(COMPLETE_PASTIE, packed_folder)
  end
end
