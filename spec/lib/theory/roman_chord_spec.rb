# frozen_string_literal: true

RSpec.describe Theory::RomanChord do
  let(:key) { 'C' }

  it 'can detect the degree' do
    expect(Theory::RomanChord.new('vii', key: key).degree).to eq(7)
  end

  it 'can detect the root note' do
    expect(Theory::RomanChord.new('I', key: key).root_note).to    be_enharmonic('C')
    expect(Theory::RomanChord.new('II', key: key).root_note).to   be_enharmonic('D')
    expect(Theory::RomanChord.new('III', key: key).root_note).to  be_enharmonic('E')
    expect(Theory::RomanChord.new('bIII', key: key).root_note).to be_enharmonic('Eb')
    expect(Theory::RomanChord.new('IV', key: key).root_note).to   be_enharmonic('F')
    expect(Theory::RomanChord.new('V', key: key).root_note).to    be_enharmonic('G')
    expect(Theory::RomanChord.new('VI', key: key).root_note).to   be_enharmonic('A')
    expect(Theory::RomanChord.new('vii', key: key).root_note).to  be_enharmonic('B')
  end

  it 'detects the quality name' do
    expect(Theory::RomanChord.new('III', key: key).quality.name).to     eq 'M'
    expect(Theory::RomanChord.new('ii', key: key).quality.name).to      eq 'm'
    expect(Theory::RomanChord.new('v7', key: key).quality.name).to      eq 'm7'
    expect(Theory::RomanChord.new('IV7', key: key).quality.name).to     eq '7'
    expect(Theory::RomanChord.new('iiio', key: key).quality.name).to    eq 'dim'
    expect(Theory::RomanChord.new('iiio7', key: key).quality.name).to   eq 'dim7'
    expect(Theory::RomanChord.new('ivø', key: key).quality.name).to     eq 'm7b5'
    expect(Theory::RomanChord.new('VIIm7b5', key: key).quality.name).to eq 'm7b5'
  end

  it 'detects the chord' do
    expect(Theory::RomanChord.new('I', key: key).chord.name).to eq Theory::Chord.new(name: 'CM').name
    expect(Theory::RomanChord.new('ii', key: key).chord.name).to eq Theory::Chord.new(name: 'Dm').name
    expect(Theory::RomanChord.new('ivdim', key: key).chord.name).to eq Theory::Chord.new(name: 'Fdim').name
    expect(Theory::RomanChord.new('VIIm7b5', key: key).chord.name).to eq Theory::Chord.new(name: 'Bm7b5').name
    expect(Theory::RomanChord.new('I7', key: key).chord.name).to eq Theory::Chord.new(name: 'C7').name
    expect(Theory::RomanChord.new('Im7', key: key).chord.name).to eq Theory::Chord.new(name: 'Cm7').name
  end

  it 'can return a notation from chord' do
    expect(Theory::RomanChord.new(chord: 'CM', key: key).notation).to eq('I')
    expect(Theory::RomanChord.new(chord: 'Dm', key: key).notation).to eq('ii')
    expect(Theory::RomanChord.new(chord: 'Fdim', key: key).notation).to eq('ivdim')
    expect(Theory::RomanChord.new(chord: 'Bm7b5', key: key).notation).to eq('viim7b5')
    expect(Theory::RomanChord.new(chord: 'C7', key: key).notation).to eq('I7')
    expect(Theory::RomanChord.new(chord: 'Cm7', key: key).notation).to eq('i7')
  end

  it 'can return its function' do
    expect(Theory::RomanChord.new('I', key: key).function).to eq   'Tonic'
    expect(Theory::RomanChord.new('ii', key: key).function).to eq  'Supertonic'
    expect(Theory::RomanChord.new('iii', key: key).function).to eq 'Mediant'
    expect(Theory::RomanChord.new('IV', key: key).function).to eq  'Subdominant'
    expect(Theory::RomanChord.new('V', key: key).function).to eq   'Dominant'
    expect(Theory::RomanChord.new('vii', key: key).function).to eq 'Leading'
    expect(Theory::RomanChord.new('vii', key: 'Am').function).to be_nil
  end
end
