# frozen_string_literal: true

RSpec.describe Theory::Interval do
  it 'can be created by 2 notes' do
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['C']).name).to  eq('P1')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['C#']).name).to eq('A1')

    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['Db']).name).to eq('m2')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['D']).name).to  eq('M2')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['D#']).name).to eq('A2')

    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['Eb']).name).to eq('m3')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['E']).name).to  eq('M3')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['E#']).name).to eq('A3')

    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['Fb']).name).to eq('d4')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['F']).name).to  eq('P4')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['F#']).name).to eq('A4')

    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['Gb']).name).to eq('d5')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['G']).name).to  eq('P5')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['G#']).name).to eq('A5')

    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['Ab']).name).to eq('m6')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['A']).name).to  eq('M6')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['A#']).name).to eq('A6')

    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['Bb']).name).to eq('m7')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['B']).name).to  eq('M7')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['B#']).name).to eq('A7')
  end

  it 'can return the interval inversion' do
    inverted_interval = Theory::Interval.new(Theory::Note['C'], Theory::Note['B']).inversion
    expect(inverted_interval.full_name).to eq('Minor Second')
  end

  it 'can create descending' do
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['Cb'], ascending: false).name).to eq('A1')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['B'],  ascending: false).name).to eq('m2')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['E'],  ascending: false).name).to eq('m6')
  end

  it 'can return an interval for a certain letter distance' do
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['F']).as(2)&.name).to be_nil
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['F']).as(3)&.name).to eq('A3')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['F']).as(4)&.name).to eq('P4')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['F']).as(5)&.name).to eq('dd5')
  end

  it 'it can return a compound interval' do
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['D']).as(9)&.name).to eq('M9')
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['D']).compound_name).to eq('M9')
  end

  it 'can return an interval only if not augmented or diminished' do
    expect(Theory::Interval.new(Theory::Note['C'], Theory::Note['F']).as!(3)&.name).to eq(nil)
  end

  it 'can return all compound intervals' do
    expect(Theory::Interval.all_compound.map(&:name)).to include(
      *%w[P8 m9 M9 m10 M10 P11 A11 P12 m13 M13 m14 M14]
    )
  end

  it 'can return all intervals, including the compound ones' do
    expect(Theory::Interval.all_including_compound.map(&:name)).to include(*%w[
                                                                     P1 m2 M2 m3 M3 P4 A4 P5 m6 M6 m7 M7
                                                                     P8 m9 M9 m10 M10 P11 A11 P12 m13 M13 m14 M14
                                                                   ])
  end

  it 'can augment' do
    expect(Theory::Interval.major_third.augment.full_name).to eq('Augmented Third')
  end

  it 'can diminish' do
    expect(Theory::Interval.major_third.diminish.full_name).to eq('Minor Third')
    expect(Theory::Interval.minor_third.diminish.full_name).to eq('Diminished Third')
  end

  it 'can double diminish' do
    expect(Theory::Interval.minor_third.diminish(2).name).to eq('dd3')
  end
end
