# frozen_string_literal: true

RSpec.describe Theory::PitchClass do
  it 'can found by frequency' do
    expect(Theory::PitchClass.new(frequency: 261.63).notation).to eq('C')
    expect(Theory::PitchClass.new(frequency: 277.18).notation).to eq('C#')
    expect(Theory::PitchClass.new(frequency: 293.66).notation).to eq('D')
    expect(Theory::PitchClass.new(frequency: 311.13).notation).to eq('D#')
    expect(Theory::PitchClass.new(frequency: 329.63).notation).to eq('E')
    expect(Theory::PitchClass.new(frequency: 349.23).notation).to eq('F')
    expect(Theory::PitchClass.new(frequency: 369.99).notation).to eq('F#')
    expect(Theory::PitchClass.new(frequency: 392.00).notation).to eq('G')
    expect(Theory::PitchClass.new(frequency: 415.30).notation).to eq('G#')
    expect(Theory::PitchClass.new(frequency: 440.00).notation).to eq('A')
    expect(Theory::PitchClass.new(frequency: 466.16).notation).to eq('A#')
    expect(Theory::PitchClass.new(frequency: 493.88).notation).to eq('B')
    expect(Theory::PitchClass.new(frequency: 7902.13).notation).to eq('B')
  end

  it 'has fundamental frequencies' do
    expect(Theory::PitchClass['A'].fundamental_frequency.octave_up(4)).to eq(440)
    expect(Theory::PitchClass['C'].frequency.octave(4).round(2)).to eq(261.63)
  end
end
