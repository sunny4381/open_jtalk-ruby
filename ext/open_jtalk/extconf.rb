require 'mkmf'

have_library('stdc++') or raise
find_executable('tar') or raise
find_executable('ar') or raise
find_executable('patch') or raise

HTS_ENGINE_ROOT = 'hts_engine_API-1.09'
OPEN_JTALK_ROOT = 'open_jtalk-1.08'

unless Dir.exists?(File.expand_path(HTS_ENGINE_ROOT, $srcdir))
  `cd #{$srcdir} && tar zxf #{HTS_ENGINE_ROOT}.tar.gz`
  status = $?.exitstatus
  raise unless status == 0
end

if File.exists?(File.expand_path("#{HTS_ENGINE_ROOT}.patch", $srcdir))
  `cd #{$srcdir} && patch -p1 -i #{File.expand_path("#{HTS_ENGINE_ROOT}.patch", $srcdir)}`
end

unless File.exists?("#{File.expand_path(HTS_ENGINE_ROOT, $srcdir)}/lib/libHTSEngine.a")
  # we need dummy libHTSEngine.a
  `ar q #{File.expand_path(HTS_ENGINE_ROOT, $srcdir)}/lib/libHTSEngine.a`
  status = $?.exitstatus
  raise unless status == 0
end

unless Dir.exists?(File.expand_path(OPEN_JTALK_ROOT, $srcdir))
  `cd #{$srcdir} && tar zxf #{OPEN_JTALK_ROOT}.tar.gz`
  status = $?.exitstatus
  raise unless status == 0
end

if File.exists?(File.expand_path("#{OPEN_JTALK_ROOT}.patch", $srcdir))
  `cd #{$srcdir} && patch -p1 -i #{File.expand_path("#{OPEN_JTALK_ROOT}.patch", $srcdir)}`
end

unless File.exists?("#{File.expand_path(OPEN_JTALK_ROOT, $srcdir)}/mecab/config.h")
  # execute configure script to create mecab/config.h
  `cd #{$srcdir}/#{OPEN_JTALK_ROOT} && ./configure --with-hts-engine-header-path=#{File.expand_path(HTS_ENGINE_ROOT, $srcdir)}/include --with-hts-engine-library-path=#{File.expand_path(HTS_ENGINE_ROOT, $srcdir)}/lib --with-charset=UTF-8`
  status = $?.exitstatus
  raise unless status == 0
end

# jpcommon
$defs << '-DHAVE_CONFIG_H'
$defs << '-DCHARSET_UTF_8'
# mecab
$defs << '-DDIC_VERSION=102'
$defs << '-DMECAB_USE_UTF8_ONLY'
$defs << '-DMECAB_DEFAULT_RC="\"dummy\""'
$defs << '-DPACKAGE="\"open_jtalk\""'
$defs << '-DVERSION="\"1.08\""'

SUBDIRS = [
  "#{OPEN_JTALK_ROOT}/jpcommon",
  "#{OPEN_JTALK_ROOT}/mecab",
  "#{OPEN_JTALK_ROOT}/mecab/src",
  "#{OPEN_JTALK_ROOT}/mecab2njd",
  "#{OPEN_JTALK_ROOT}/njd",
  "#{OPEN_JTALK_ROOT}/njd2jpcommon",
  "#{OPEN_JTALK_ROOT}/njd_set_accent_phrase",
  "#{OPEN_JTALK_ROOT}/njd_set_accent_type",
  "#{OPEN_JTALK_ROOT}/njd_set_digit",
  "#{OPEN_JTALK_ROOT}/njd_set_long_vowel",
  "#{OPEN_JTALK_ROOT}/njd_set_pronunciation",
  "#{OPEN_JTALK_ROOT}/njd_set_unvoiced_vowel",
  "#{OPEN_JTALK_ROOT}/text2mecab",
  "#{HTS_ENGINE_ROOT}/include",
  "#{HTS_ENGINE_ROOT}/lib" ]

SUBDIRS.each do |d|
  $INCFLAGS << " -I$(srcdir)/#{d}"
end

$objs ||= []
$objs << "open_jtalk-ruby.#{$OBJEXT}"

SRC_EXT = %w[c m cc mm cxx cpp C]
SUBDIRS.each do |d|
  Dir[File.join("#{$srcdir}/#{d}", "*.{#{SRC_EXT.join(%q{,})}}")].each do |c|
    c.gsub!(%r[^#{$srcdir}/], '')
    c.gsub!(%r[(#{SRC_EXT.join(%q{|})})$], $OBJEXT)
    $objs << c
  end
end

$CXXFLAGS += ' $(cflags)' unless $CXXFLAGS.include?('$(cflags)')
$warnflags.gsub!('-Wimplicit-function-declaration', '')
$warnflags.gsub!('-Wdeclaration-after-statement', '')

create_makefile('open_jtalk/open_jtalk')

SUBDIRS.each do |dir|
  FileUtils.mkdir_p(dir) unless Dir.exists?(dir)
end
