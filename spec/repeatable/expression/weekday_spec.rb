require 'spec_helper'

module Repeatable
  module Expression
    describe Weekday do
      describe '#include?' do
        subject { described_class.new(weekday: 4) }

        it 'returns true for dates matching the weekday given' do
          expect(subject).to include(Date.new(2015, 1, 1))
        end

        it 'returns false for dates not matching the weekday given' do
          expect(subject).not_to include(Date.new(2015, 1, 2))
        end
      end
    end
  end
end
