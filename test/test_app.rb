require File.dirname(__FILE__) + '/test_helper'

class TestApp < Test::Unit::TestCase
  attr_reader :base_folder, :target_folder

  def setup
    @base_folder    = File.dirname(__FILE__) + "/fixtures"
    @target_folder = File.dirname(__FILE__) + "/unpack"
    FileUtils.mkdir_p target_folder
  end

  def teardown
    FileUtils.rm_rf target_folder
  end

  def test_pack_current_folder
    PastiePacker::API.any_instance.expects(:paste).
      with($complete_pastie_and_header, 'ruby', false).
      returns("http://pastie.caboo.se/123456")
    FileUtils.cd base_folder do
      PastiePacker.run
    end
  end

  def test_pack_with_file_names
    PastiePacker::API.any_instance.expects(:paste).
      with($complete_pastie_and_header_for_files, 'ruby', false).
      returns("http://pastie.caboo.se/123456")
    files = ["README.txt\n", "lib/myapp.rb\n"]
    PastiePacker.any_instance.expects(:input_lines).returns(files)
    FileUtils.cd base_folder do
      PastiePacker.run
    end
  end

  def test_unpack_within_current_folder
    PastiePacker.any_instance.expects(:fetch_pastie).
      with("http://pastie.caboo.se/123456").
      returns($complete_pastie_and_header)
    PastiePacker.any_instance.expects(:parse_options)
    PastiePacker.any_instance.expects(:args).returns(["http://pastie.caboo.se/123456"])
    FileUtils.cd target_folder do
      PastiePacker.run("http://pastie.caboo.se/123456")
    end
    assert(File.directory?("#{target_folder}/123456"), "/123456 folder not created")
    diff = `diff -ur #{base_folder} #{target_folder}/123456`
    assert_equal("", diff)
  end

  def test_unpack_within_current_folder_raw_txt
    PastiePacker.any_instance.expects(:fetch_pastie).
      with("http://pastie.caboo.se/123456").
      returns($complete_pastie_and_header)
    PastiePacker.any_instance.expects(:parse_options)
    PastiePacker.any_instance.expects(:args).returns(["http://pastie.caboo.se/123456.txt"])
    FileUtils.cd target_folder do
      PastiePacker.run("http://pastie.caboo.se/123456.txt")
    end
    assert(File.directory?("#{target_folder}/123456"), "/123456 folder not created")
    diff = `diff -ur #{base_folder} #{target_folder}/123456`
    assert_equal("", diff)
  end

end
