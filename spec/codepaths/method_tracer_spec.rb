require 'spec_helper'

module Codepaths
  RSpec.describe MethodTracer do
    subject(:tracer) do
      MethodTracer.new do
        receiver.kind_of?(Consumed)
      end
    end

    describe '#stacktrace_tree' do
      before do
        tracer.trace do
          Consumer.new.a
          Consumer.new.c
        end
      end

      it 'returns a tracer' do
        expect(tracer.stacktrace_tree).to be_a_kind_of StacktraceTree
      end
    end
  end
end
