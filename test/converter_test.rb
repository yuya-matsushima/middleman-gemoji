require 'minitest/autorun'
require 'middleman'
require '../lib/middleman-gemoji/converter.rb'

module Middleman
  module Gemoji
    class ConverterTest < MiniTest::Unit::TestCase
      def setup
        app = ::Middleman::Application
        options = {
          emoji_dir: '/emoji'
        }
        @converter = Converter.new(app.config, options)
      end

      def test_size
        assert_equal 'width="45" height="45"', @converter.send(:size, 45)
      end

      def test_style
        assert_equal 'style="margin: 10"', @converter.send(:style, 'margin: 10')
      end

      def test_style_provided_empty
        assert_empty @converter.send(:style, nil)
      end

      def test_base_path_emoji_not_exist
        @converter.instance_variable_set(:@emoji_exist, false)

        cdn_url = 'https://assets-cdn.github.com/images/icons/emoji/'
        assert_equal cdn_url, @converter.send(:base_path)
      end

      def test_base_path_emoji_exist
        config = @converter.instance_variable_get(:@config)
        config.http_prefix = '/';
        @converter.instance_variable_set(:@emoji_exist, true)
        @converter.instance_variable_set(:@config, config)

        assert_equal '/emoji', @converter.send(:base_path)
      end

      def test_base_path_http_prefix_start_with_http
        config = @converter.instance_variable_get(:@config)
        config.http_prefix = 'http://example.com/';
        @converter.instance_variable_set(:@emoji_exist, true)
        @converter.instance_variable_set(:@config, config)

        assert_equal 'http://example.com/emoji', @converter.send(:base_path)
      end

      def test_src_with_cdn
        @converter.instance_variable_set(:@emoji_exist, false)

        expected = 'src="https://assets-cdn.github.com/images/icons/emoji/something.png"'
        assert_equal expected, @converter.send(:src, 'something.png')
      end

      def test_convert
        converted = @converter.convert('<span>:+1:</span>')
        expected = '<span><img class="gemoji" alt="+1" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f44d.png" /></span>'
        assert_equal expected, converted
      end

      def test_convert_with_options
        options = {
          size: 40,
          style: 'padding: 3px'
        }
        @converter.instance_variable_set(:@options, options)

        converted = @converter.convert('<span>:+1:</span>')
        expected = '<span><img class="gemoji" alt="+1" src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f44d.png" width="40" height="40" style="padding: 3px" /></span>'
        assert_equal expected, converted
      end
    end
  end
end
