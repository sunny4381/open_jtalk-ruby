OpenJtalk::Ruby
===

This is ruby gem of [Open JTalk](http://open-jtalk.sourceforge.net).

This ruby gem has "Battery Included" philosophy.
You don't need extra gems or libs except writing a result as mp3.

[![Build Status](https://travis-ci.org/sunny4381/open_jtalk-ruby.svg?branch=master)](https://travis-ci.org/sunny4381/open_jtalk-ruby)
[![Coverage Status](https://coveralls.io/repos/sunny4381/open_jtalk-ruby/badge.svg?branch=master)](https://coveralls.io/r/sunny4381/open_jtalk-ruby?branch=master)
[![Code Climate](https://codeclimate.com/github/sunny4381/open_jtalk-ruby/badges/gpa.svg)](https://codeclimate.com/github/sunny4381/open_jtalk-ruby)

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
    $ gem install open_jtalk-ruby-0.4.gem

## Usage

```ruby
require 'open_jtalk'
text = "こんにちは。".encode("UTF-8")

OpenJtalk.load(OpenJtalk::Config::Mei::NORMAL) do |openjtalk|
  header, data = openjtalk.synthesis(openjtalk.normalize_text(text))

  OpenJtalk::WaveFileWriter.save("a.wav", header, data)
end
```

### Configuration

open_jtalk-ruby contains these configurations:

* OpenJtalk::Config::Mei::NORMAL: this is default configuration of female model.
* OpenJtalk::Config::Mei::ANGRY
* OpenJtalk::Config::Mei::BASHFUL
* OpenJtalk::Config::Mei::HAPPY
* OpenJtalk::Config::Mei::SAD
* OpenJtalk::Config::Mei::FAST
* OpenJtalk::Config::Mei::SLOW
* OpenJtalk::Config::Mei::HIGH
* OpenJtalk::Config::Mei::LOW
* OpenJtalk::Config::Nitech::NORMAL: this is default configuration of male model.
* OpenJtalk::Config::Nitech::FAST
* OpenJtalk::Config::Nitech::SLOW
* OpenJtalk::Config::Nitech::HIGH
* OpenJtalk::Config::Nitech::LOW

### Writer

open_jtalk-ruby contains these writers:

* OpenJtalk::WaveFileWriter: WAV File Writer.
* OpenJtalk::Mp3FileWriter: MP3 File Writer. this writer requires 'lame'(>= 0.0.3) and `libmp3lame.so`.

### MP3 Streaming Synthesizer

You can simply set `OpenJtalk::Mp3StreamingSynthesizer` instance to your controller's `response_body`
if you are developing rails application.

    response.headers['Content-Type'] = 'audio/mp3'
    response_body = OpenJtalk::Mp3StreamingSynthesizer.new(config, text)

A controller responds mp3 data stream in chunked encoding.

### Supported Encoding

open_jtalk-ruby supports only UTF-8.

### Supported Platform

Platforma  | Support
-----------|---------
Windows    | NO
Linux      | YES
Mac        | YES
Other Unix | Meybe YES

## Contributing

1. Fork it ( https://github.com/sunny4381/open_jtalk-ruby/fork )
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
