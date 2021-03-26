# typed: true
module Repeatable
  module Expression
    class Weekday < Date
      def initialize(weekday:)
        @weekday = weekday
      end

      def include?(date)
        date.wday == weekday
      end

      private

      attr_reader :weekday
    end
  end
end
