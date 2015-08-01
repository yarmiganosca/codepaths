require 'tree'

module Codepaths
  class StacktraceTree
    attr_accessor :tree

    def initialize(stacktrace, *stacktraces)
      self.tree = stacktrace
        .map(&Tree::TreeNode.public_method(:new))
        .reduce(:<<)

      stacktraces.each(&public_method(:<<))
    end

    def <<(stacktrace)
      stacktrace_tree = self.class.new(stacktrace)

      self.tree = tree.merge(stacktrace_tree.tree)

      self
    end

    def print_tree
      parent_of_first_node_with_siblings.print_tree(1)

      nil
    end

    def parent_of_first_node_with_siblings
      tree.each do |node|
        return node.parent if !node.is_only_child?
      end

      tree
    end
  end
end

