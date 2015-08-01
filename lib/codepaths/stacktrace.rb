module Codepaths
  class Stacktrace
    include Enumerable

    attr_reader :time, :caller_locations

    def initialize(binding)
      library_lines = 3

      @caller_locations = binding.send(:caller_locations)[library_lines..-1].reverse
      @time             = Time.now
    end

    def lines
      caller_locations.map do |location|
        "#{location.path}[#{location.label}]"
      end
    end

    def each
      lines.each { |line| yield line }
    end
  end
end
