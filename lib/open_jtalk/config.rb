require 'yaml'

class OpenJtalk
  class Config
    CONFIG_ROOT = File.dirname(__FILE__)

    def initialize(config, dir = CONFIG_ROOT)
      # make path absolute
      [ "dicdir", "userdic", "model" ].each do |name|
        config[name] = File.expand_path(config[name], dir) if config.key?(name)
      end

      @dir = dir
      @config = config
    end

    def [](key)
      return @config[key]
    end

    def to_hash
     return @config.dup
    end

    def copy
      config_copy = @config.dup
      yield config_copy if block_given?
      return self.class.new(config_copy, @dir)
    end

    def self.load_file(file)
      cfg = YAML.load_file(file)
      dir = File.dirname(File.absolute_path(file))

      return new(cfg, dir)
    end

    module Mei
      NORMAL = Config.load_file(File.expand_path(
        "normal.yml", CONFIG_ROOT))
      ANGRY = Config.load_file(File.expand_path(
        "angry.yml", CONFIG_ROOT))
      BASHFUL = Config.load_file(File.expand_path(
        "bashful.yml", CONFIG_ROOT))
      HAPPY = Config.load_file(File.expand_path(
        "happy.yml", CONFIG_ROOT))
      SAD = Config.load_file(File.expand_path(
        "sad.yml", CONFIG_ROOT))
      FAST = Config.load_file(File.expand_path(
        "fast.yml", CONFIG_ROOT))
      SLOW = Config.load_file(File.expand_path(
        "slow.yml", CONFIG_ROOT))
      HIGH = Config.load_file(File.expand_path(
        "high.yml", CONFIG_ROOT))
      LOW = Config.load_file(File.expand_path(
        "low.yml", CONFIG_ROOT))
    end
  end
end
