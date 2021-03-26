# typed: true
module Repeatable
  module Expression
    class Set < Base
      attr_reader :elements

      def initialize(*elements)
        @elements = elements.flatten.uniq
      end

      def <<(element)
        elements << element unless elements.include?(element)
        self
      end

      def to_h
        Hash[hash_key, elements.map(&:to_h)]
      end

      def ==(other)
        other.is_a?(self.class) &&
          elements.size == other.elements.size &&
          other.elements.all? { |e| elements.include?(e) }
      end
    end
  end
end
