require './test/test_helper'
require './lib/middleman-gemoji/converter'

class TestConverter < Minitest::Test
  def setup
    @root = ENV['MM_ROOT']
    ENV['MM_ROOT'] = File.join(Dir.pwd, 'fixtures', 'gemoji-file-exist')
    @converter = converter
  end

  def teardown
    ENV['MM_ROOT'] = @root
  end

  def converter(app: Middleman::Application.new, size: nil, style: nil, emoji_dir: 'images/emoji')
    Middleman::Gemoji::Converter.new(app, {size: size, style: style, emoji_dir: emoji_dir})
  end

  def test_initialize
    assert_instance_of(Middleman::Application, @converter.app)
  end

  def test_initialize_raise_runtime_error
    assert_raises RuntimeError do
      converter(app: nil)
    end
  end

  def test_convert
    assert_equal(
      '<img class="gemoji" alt="+1" src="/images/emoji/unicode/1f44d.png" />',
      @converter.convert(':+1:')
    );
  end

  def test_convert_received_blank
    assert_equal('', @converter.convert(''))
    assert_equal(nil, @converter.convert(nil))
  end

  def test_convert_received_normal_string
    assert_equal('hoge', @converter.convert('hoge'));
  end

  def test_src
    path = @converter.src('unicode/1f44d.png')
    assert_equal('src="/images/emoji/unicode/1f44d.png"', path)
  end

  def test_src_with_cdn
    ENV['MM_ROOT'] = File.join(@converter.app.root, 'fixtures', 'gemoji-file-not-exist')
    @converter.set_base_path
    path = @converter.src('unicode/1f44d.png')
    assert_equal(
      'src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f44d.png"',
      path
    )
  end

  def test_size_rerutn_nil
    @converter.options[:size] = nil
    assert_nil(@converter.size)
  end

  def test_size_return_string
    @converter.options[:size] = 40
    assert_equal('width="40" height="40"', @converter.size)
  end

  def test_style_return_nil
    @converter.options[:style] = nil
    assert_nil(@converter.style)
  end

  def test_style_return_string
    @converter.options[:style] = 'padding-right: .2em'
    assert_equal('style="padding-right: .2em"', @converter.style)
  end

  def test_emoji_file_exist_return_true
    assert_equal(true, @converter.emoji_file_exist?)
  end

  def test_emoji_file_exist_return_false
    ENV['MM_ROOT'] = File.join(@converter.app.root, 'fixtures', 'gemoji-file-not-exist')
    assert_equal(false, @converter.emoji_file_exist?)
  end

  def test_set_base_path__cdn
    ENV['MM_ROOT'] = File.join(@converter.app.root, 'fixtures', 'gemoji-file-not-exist')
    @converter.set_base_path
    assert_equal(
      'https://assets-cdn.github.com/images/icons/emoji/',
      @converter.base_path
    )
  end

  def test_set_base_path__relative_path
    assert_equal('/images/emoji', @converter.base_path)
  end

  def test_set_base_path__full_path
    @converter.app.config[:http_prefix] = 'http://example.com/'
    @converter.set_base_path
    assert_equal('http://example.com/images/emoji', @converter.base_path)
  end
end
