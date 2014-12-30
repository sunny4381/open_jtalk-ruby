OpenJtalk::Ruby
===

This is ruby bindings of [Open JTalk](http://open-jtalk.sourceforge.net).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'open_jtalk-ruby', git: 'git://github.com/sunny4381/open_jtalk-ruby.git'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ git clone git://github.com/sunny4381/open_jtalk-ruby.git
    $ cd open_jtalk-ruby
    $ gem build open_jtalk-ruby.gemspec
    $ gem install open_jtalk-ruby-0.3.gem

## Usage

```ruby
require 'open_jtalk'
text = "こんにちは。"

config = OpenJtalk::Config::NORMAL
openjtalk = OpenJtalk.load(config.to_hash)
header, data = openjtalk.synthesis(openjtalk.normalize_text(text))

OpenJtalk::WaveFileWriter.save("/tmp/c.wav", header, data)
```

### Configuration

open_jtalk-ruby contains these configurations:

* OpenJtalk::Config::NORMAL: this is default configuration.
* OpenJtalk::Config::ANGRY
* OpenJtalk::Config::BASHFUL
* OpenJtalk::Config::HAPPY
* OpenJtalk::Config::SAD
* OpenJtalk::Config::FAST
* OpenJtalk::Config::SLOW
* OpenJtalk::Config::HIGH
* OpenJtalk::Config::LOW

### Writer

open_jtalk-ruby contains these writers:

* OpenJtalk::WaveFileWriter: WAV File Writer.
* OpenJtalk::Mp3FileWriter: MP3 File Writer. this writer requires 'lame'(>= 0.0.3).

### Supported Encoding

open_jtalk-ruby supports only UTF-8.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/open_jtalk-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

open_jtalk-ruby contains several sub modules, and each module has released under its own license.

* open_jtalk-ruby is released under [BSD 2 Clause](http://opensource.org/licenses/BSD-2-Clause).
* open_jtalk is released under [Modified BSD license](http://www.opensource.org/).
* hts_engine_api is released under [Modified BSD license](http://www.opensource.org/).
* MeCab is released under [New BSD License](http://opensource.org/licenses/BSD-3-Clause).
