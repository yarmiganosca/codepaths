require 'codepaths/trace_logger'
require 'codepaths/stacktrace_tree'

module Codepaths
  class MethodTracer
    def initialize(logger = default_logger, &conditions)
      @logger     = logger
      @conditions = conditions
    end

    def trace(&blk)
      tracepoint.enable(&blk)

      self
    end

    def stacktraces
      @logger.stacktraces
    end

    def stacktrace_tree
      StacktraceTree.new(*stacktraces)
    end

    private

    def tracepoint
      logger     = @logger
      conditions = @conditions

      TracePoint.new(:call) do |tp|
        logger.call(tp) if conditions && tp.instance_exec(&conditions)
      end
    end

    def default_logger
      TraceLogger.new
    end
  end
end
