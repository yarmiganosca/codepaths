require 'codepaths/stacktrace'

module Codepaths
  class TraceLogger
    attr_reader :signature, :stacktraces

    def initialize
      @signature   = [git_revision, hostname, process_id]
      @stacktraces = []
    end

    def call(tracepoint)
      stacktraces << Stacktrace.new(tracepoint.binding)
    end

    private

    def hostname
      `hostname`.strip
    end

    def process_id
      $$
    end

    def git_revision
      `git log -n 1 | head -1 | cut -d ' ' -f 2`.strip
    end
  end
end
