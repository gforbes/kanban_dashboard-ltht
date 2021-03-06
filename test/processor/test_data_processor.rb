require 'minitest/autorun'
require 'minitest/mock'
require 'shoulda/matchers'
require 'shoulda/context'

require_relative '../../lib/processor/data_processor'
require_relative '../../lib/model/work_item'

class TestDataProcessor < Minitest::Test

  context 'DataProcessor' do

    setup do
      setup_work_items
      setup_readers
      setup_widget_processors
    end

    should 'read data from file' do
      @processor = DataProcessor.new(@data_reader, @config_reader, @widget_processors)
      @processor.process_data

      @data_reader.verify
      @config_reader.verify
      @first_widget_processor.verify
      @second_widget_processor.verify
    end

  end

  private def setup_readers
    @data_reader = MiniTest::Mock.new
    @config_reader = MiniTest::Mock.new
    @data_reader.expect :read_data, @work_items
    @config_reader.expect :read_config, @config
  end

  private def setup_widget_processors
    @first_widget_processor = MiniTest::Mock.new
    @second_widget_processor = MiniTest::Mock.new
    process_work_items(@first_widget_processor)
    process_work_items(@second_widget_processor)

    @widget_processors = [@first_widget_processor, @second_widget_processor]
  end

  private def process_work_items(widget_processor)
    widget_processor.expect :process, nil, [@work_items, @config]
    widget_processor.expect :output, nil
  end

  private def setup_work_items
    @work_items = [WorkItem.new(:start_date => "10/3/16", :complete_date => "21/3/16"),
                   WorkItem.new(:start_date => "15/3/16", :complete_date => "21/3/16")]
    @config = {:forecast_config => {:start_date => "10/3/16", :number_of_stories => 30}}
  end

end