# middleman-emoji

middleman-emoji is Github-flavored emoji plugin for Middleman.

## Installation


```ruby
gem 'middleman-gemoji'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install middleman-gemoji
```

You can download emoji files form [gemoji](https://rubygems.org/gems/gemoji):

```sh
$ middleman gemoji --path images/emoji
```

You can choose destination path with `--path` or `-p` option.

## Usage

In config.rb:

```ruby
activate :gemoji
```

Or with options:

```ruby
activate :gemoji, :size => 20, :style => "vertical-align: middlele", :emoji_dir => "images/emoji"
```

Then you can use emoji in your template.

## Contributing

1. Fork it ( https://github.com/yterajima/middleman-gemoji/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
