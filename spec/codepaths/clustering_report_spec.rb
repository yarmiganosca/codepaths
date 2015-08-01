require 'spec_helper'

module Codepaths
  RSpec.describe ClusteringReport do
    subject(:report) { ClusteringReport.new(tracer.stacktraces) }

    let(:tracer) do
      MethodTracer.new do
        receiver.kind_of?(Consumed)
      end
    end

    before do
      tracer.trace do
        Consumer.new.a
        Consumer.new.c
      end
    end

    describe '#clusters' do
      subject(:clusters) { report.clusters}

      it 'acts like a hash of the clusters keyed to their consuming method' do
        expect(clusters.size).to eq 2

        endings = {
          'consumer.rb[a]' => ['consumed.rb[a]', 'consumed.rb[b]'],
          'consumer.rb[c]' => ['consumed.rb[c]', 'consumed.rb[d]']
        }

        endings.each.with_index do |(consumer_ending, consumed_endings), consumer_index|
          expect(clusters.keys[consumer_index]).to end_with consumer_ending

          consumed_endings.each.with_index do |consumed_ending, consumed_index|
            expect(clusters.values[consumer_index][consumed_index]).to end_with consumed_ending
          end
        end
      end
    end
  end
end
