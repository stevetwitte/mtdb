# frozen_string_literal: true

RSpec.describe Theory::IntervalClass do
  it 'may be created by full name' do
    expect(Theory::IntervalClass['Major Second']).to   eq(Theory::IntervalClass['M2'])
    expect(Theory::IntervalClass['Major Third']).to    eq(Theory::IntervalClass['M3'])
    expect(Theory::IntervalClass['Minor Seventh']).to  eq(Theory::IntervalClass['m7'])
    expect(Theory::IntervalClass['Perfect Unison']).to eq(Theory::IntervalClass['P1'])
    expect(Theory::IntervalClass['Perfect Octave']).to eq(Theory::IntervalClass['P1'])
    expect(Theory::IntervalClass['Minor Second']).to   eq(Theory::IntervalClass['m2'])
  end
end
