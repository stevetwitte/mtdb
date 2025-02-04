# frozen_string_literal: true

RSpec.describe Theory::IntervalSequence do
  it 'is organized by default' do
    expect(Theory::IntervalSequence.new(notes: %w[D F C A]).intervals_semitones)
      .to eq([0, 3, 7, 10])
    expect(Theory::IntervalSequence.new(notes: %w[D F C A#]).intervals_semitones)
      .to eq([0, 3, 8, 10])
  end

  it 'can find the relative distances' do
    expect(Theory::IntervalSequence.new(0, 3, 5, 7, 10).relative_intervals)
      .to eq([3, 2, 2, 3, 2])
  end

  it 'can be instantiated from distances' do
    expect(Theory::IntervalSequence.new(relative_intervals: [3, 2, 2, 3, 2]).intervals_semitones)
      .to eq([0, 3, 5, 7, 10])
  end

  it 'can be created from Notes' do
    expect(Theory::IntervalSequence.new(
      notes: [Theory::Note['A'], Theory::Note['E'], Theory::Note['G'], Theory::Note['C#']]
    ).intervals_semitones).to eq([0, 4, 7, 10])
  end

  it 'can return named intervals' do
    expect(Theory::IntervalSequence.new(0, 4, 7, 10).names)
      .to eq(%w[P1 M3 P5 m7])
  end

  it 'has helper methods for interval names' do
    expect(Theory::IntervalSequence.new(0, 3, 5, 7, 10).has_minor_third?).to eq(true)
    expect(Theory::IntervalSequence.new(0, 3, 5, 7, 10).has_perfect_fifth?).to eq(true)
    expect(Theory::IntervalSequence.new(0, 3, 5, 7, 10).has_minor_second?).to eq(false)
  end

  it 'can return inversions' do
    interval = Theory::IntervalSequence.new(notes: %w[C E G])
    expect(interval.inversion(0).intervals_semitones).to eq([0, 4, 7])
    expect(interval.inversion(1).intervals_semitones).to eq([0, 3, 8])
    expect(interval.inversion(2).intervals_semitones).to eq([0, 5, 9])
  end

  it 'returns interval by ordinal' do
    expect(Theory::IntervalSequence.new(0, 3, 5, 7, 10).third).to eq(Theory::Interval.minor_third)
    expect(Theory::IntervalSequence.new(0, 3, 5, 7, 10).third).to_not eq(Theory::Interval.major_third)
    expect(Theory::IntervalSequence.new(0, 3, 7, 10).fifth.full_name).to eq('Perfect Fifth')
    expect(Theory::IntervalSequence.new(0, 3, 8, 10).fifth.full_name).to eq('Augmented Fifth')
    expect(Theory::IntervalSequence.new(0, 3, 6, 10).fifth.full_name).to eq('Diminished Fifth')
    expect(Theory::IntervalSequence.new(0, 3, 6, 9).sixth.full_name).to eq('Major Sixth')
  end

  it 'has an ordinal with bang that doesnt return dim or aug' do
    expect(Theory::IntervalSequence.new(0, 3, 9).sixth!.full_name).to eq('Major Sixth')
    expect(Theory::IntervalSequence.new(0, 3, 8).sixth!.full_name).to eq('Minor Sixth')
    expect(Theory::IntervalSequence.new(0, 3, 7).sixth.full_name).to eq('Diminished Sixth')
    expect(Theory::IntervalSequence.new(0, 3, 7).sixth!).to be_nil
  end

  it 'check if has an ordinal' do
    expect(Theory::IntervalSequence.new(0, 3, 5, 7, 10).has_third?).to be_truthy
    expect(Theory::IntervalSequence.new(0, 2, 5, 7, 10).has_second?).to be_truthy
  end
end
