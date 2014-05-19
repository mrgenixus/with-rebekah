module Interaction
  def query_user query, default = nil
    query += default.nil? ? '' : " [#{default}]"
    puts query
    response = gets.chomp
    response == "" ? (default || "") : response
  end

  def screen loop_prompt = "continue or quit", responses = ['c', 'q']
    begin
      yield if block_given?

      continue = control *responses do
        query_user loop_prompt, responses.first
      end
    end while continue.downcase != responses.first.downcase
  end

  def control *values
    value = values[0]

    begin
      value = yield if block_given?

      if ! values.include? value
        puts "Invalid input, please enter one of #{values.join(', ')}"
      end

      value
    end until values.include? value

    value
  end

  def confirm message = "Are you Sure"
    summary = ''
    screen message, ['y', 'n'] do
      summary = yield if block_given?
      puts summary
    end
    summary
  end

  class Menu
    def initialize
      @options = []
    end

    def register_option title, &block
      @options << {title: title, block: block} if block_given?
    end

    def option_responses
      @options.count.times.map(&:to_s)
    end

    def exec message = "Select an option", end_value = "q"
      begin

        @options.each_with_index.each { |option, index| puts "#{index}: #{option[:title]}" }

        puts "#{end_value}: Quit"

        response = control end_value, *option_responses do
          query_user message
        end

        if response != end_value
          selected_option = @options[response.to_i]

          selected_option[:block].call
        end

      end until response == end_value
    end
  end
end
