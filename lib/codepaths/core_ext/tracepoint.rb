module Codepaths
  module Tracepoint
    def receiver
      binding.eval('self')
    end
  end
end

TracePoint.send(:include, Codepaths::Tracepoint)
    
