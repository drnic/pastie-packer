require File.dirname(__FILE__) + '/test_helper'

class TestApp < Test::Unit::TestCase
  attr_reader :base_folder, :target_folder

  def setup
    @base_folder    = File.dirname(__FILE__) + "/fixtures/sample_app"
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
      with($some_files_and_header, 'ruby', false).
      returns("http://pastie.caboo.se/123456")
    files = ["README.txt\n", "lib/myapp.rb\n"]
    PastiePacker.any_instance.expects(:input_lines).returns(files)
    FileUtils.cd base_folder do
      PastiePacker.run
    end
  end

  def test_pack_with_extra_comment
    pastie = PastiePacker.new
    pastie.extra_message = 'This is a bonus comment.'
    PastiePacker::API.any_instance.expects(:paste).
      with($complete_pastie_and_header_and_comment, nil, nil).
      returns("http://pastie.caboo.se/123456")
    FileUtils.cd base_folder do
      pastie.do_pack
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

  def test_unpack_private_pastie
    PastiePacker.any_instance.expects(:args).
      returns(["http://pastie.caboo.se/private/5hwfheniddqmyasmfcxaw"])
    private_pastie_html = open(File.dirname(__FILE__) + "/fixtures/private_pastie.html")
    PastiePacker.any_instance.expects(:fetch_pastie).
      with("http://pastie.caboo.se/private/5hwfheniddqmyasmfcxaw").
      returns(private_pastie_html)
    PastiePacker.any_instance.expects(:fetch_pastie).
      with("http://pastie.caboo.se/175214.txt?key=5hwfheniddqmyasmfcxaw").
      returns($complete_pastie_and_header)
    PastiePacker.any_instance.expects(:parse_options)
    FileUtils.cd target_folder do
      PastiePacker.run("http://pastie.caboo.se/private/5hwfheniddqmyasmfcxaw")
    end
    assert(File.directory?("#{target_folder}/5hwfheniddqmyasmfcxaw"), "/5hwfheniddqmyasmfcxaw folder not created")
    diff = `diff -ur #{base_folder} #{target_folder}/5hwfheniddqmyasmfcxaw`
    assert_equal("", diff)
  end
end
