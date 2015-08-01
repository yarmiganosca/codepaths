require 'codepaths/stacktrace_tree'

module Codepaths
  class ClusteringReport
    attr_reader :stacktrace_tree

    def initialize(stacktraces)
      @stacktrace_tree = StacktraceTree.new(*stacktraces)
    end

    def clusters
      cluster_roots.reduce({}) do |clusters, cluster_root|
        clusters[cluster_root.name] = cluster_root.each_leaf.to_a.map(&:name)
        clusters
      end
    end

    private

    def cluster_roots
      stacktrace_tree.parent_of_first_node_with_siblings.children
    end
  end
end
