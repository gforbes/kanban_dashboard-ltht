class ForecastInput

  attr_accessor :start_date, :number_of_stories, :story_split_rate_low, :story_split_rate_high

  def initialize(args)
    args.each do |k, v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def to_s
    "Start Date: #{@start_date}, Number of stories: #{@number_of_stories}, Story Split rate low: #{@story_split_rate_low}, Story Split rate high: #{@story_split_rate_high}, object_id: #{"0x00%x" % (object_id << 1)})"
  end

end