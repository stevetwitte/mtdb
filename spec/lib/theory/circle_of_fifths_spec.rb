# frozen_string_literal: true

RSpec.describe Theory::CircleOfFifths do
  it 'has 84 notes when size is not specified' do
    expect(Theory::CircleOfFifths.new.notes.size).to eq(84)
  end

  it 'return from a note and a size' do
    expect(Theory::CircleOfFifths.new(Note['C'], 7).notes.map(&:name))
      .to contain_exactly *%w[C D E F G A B]

    expect(Theory::CircleOfFifths.new(Note['C#'], 7).notes.map(&:name))
      .to contain_exactly *%w[C# D# E# F# G# A# B#]

    expect(Theory::CircleOfFifths.new(Note['Bb'], 7).notes.map(&:name))
      .to contain_exactly *%w[C D Eb F G A Bb]

    expect(Theory::CircleOfFifths.new(Note['Ab'], 7).notes.map(&:name))
      .to contain_exactly *%w[C Db Eb F G Ab Bb]
  end
end
