require 'active_support/core_ext/string/inflections'

module Repeatable
  class Schedule
    def initialize(args)
      @expression = build_expression(args)
    end

    def occurrences(start_date, end_date)
      (start_date..end_date).select { |date| occurring?(date) }
    end

    def next_occurrence(start_date = Date.today)
      date = start_date
      until occurring?(date)
        date += 1
      end
      date
    end

    def occurring?(date = Date.today)
      expression.include?(date)
    end

    private

    attr_reader :expression

    def build_expression(hash)
      if hash.length != 1
        fail "Invalid expression: '#{hash}' should have single key and value"
      else
        expression_for(*hash.first)
      end
    end

    def expression_for(key, value)
      klass = "repeatable/expression/#{key}".classify.safe_constantize
      case klass
      when nil
        fail "Unknown mapping: Can't map key '#{key.inspect}' to an expression class"
      when Repeatable::Expression::Set
        args = value.map { |hash| build_expression(hash) }
        klass.new(*args)
      else
        klass.new(value)
      end
    end
  end
end
