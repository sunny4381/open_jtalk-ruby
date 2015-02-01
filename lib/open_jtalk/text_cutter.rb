class OpenJtalk::TextCutter
  include Enumerable

  def initialize(text)
    @text = text
  end

  def each(&block)
    e = @text.each_line
    e = e.lazy if e.respond_to?(:lazy)

    # remove whites
    e = e.map do |line|
      remote_whites line
    end

    # filter out blanks
    e = e.select do |line|
      !line.empty?
    end

    e.each(&block)
  end

  private

  def remote_whites(line)
    line.chomp.strip
  end
end
