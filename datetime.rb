class DateTimeFormat
  FORMATS = {
    date: {
      'year' => '%Y',
      'month' => '%m',
      'day' => '%d'
    },
    time: {
      'hour' => '%H',
      'minute' => '%M',
      'second' => '%S'
    }
  }.freeze

  def initialize(date, format)
    @date = date
    @format = format ? format.split(',') : []
    @wrong = []
    @converted = []
    @formatted = @date.strftime(convert_format)
  end

  def wrong?
    @wrong.any?
  end

  def to_s
    wrong? ? "Unknown format #{@wrong}" : @formatted
  end

  private

  def check_format(format)
    new_format = FORMATS[:date][format] || FORMATS[:time][format]
    new_format ? @converted << new_format : @wrong << format
  end

  def convert_format
    @format.each { |f| check_format(f) }
    @converted.join('-')
  end
end
