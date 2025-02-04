# frozen_string_literal: true

RSpec.describe Theory::Pitch do
  it 'can be created by frequency' do
    expect(Theory::Pitch.new(frequency: 8.176).integer).to  eq(0)
    expect(Theory::Pitch.new(frequency: 8.662).integer).to  eq(1)
    expect(Theory::Pitch.new(frequency: 15.434).integer).to eq(11)
    expect(Theory::Pitch.new(frequency: 440.0).integer).to  eq(69)
    expect(Theory::Pitch.new(frequency: 7040.0).integer).to eq(117)
  end

  it 'can be created by notation' do
    expect(Theory::Pitch.new('C0').integer).to eq(12)
    expect(Theory::Pitch.new('C#0').integer).to eq(13)
    expect(Theory::Pitch.new('A4').integer).to eq(69)
    expect(Theory::Pitch.new('D12').integer).to eq(158)
    expect(Theory::Pitch.new('F3').integer).to eq(53)
  end

  it 'can be created by notation' do
    expect(Theory::Pitch.new(note: 'C',  octave: 0).integer).to eq(12)
    expect(Theory::Pitch.new(note: 'C#', octave: 0).integer).to eq(13)
    expect(Theory::Pitch.new(note: 'A',  octave: 4).integer).to eq(69)
    expect(Theory::Pitch.new(note: 'D',  octave: 12).integer).to eq(158)
    expect(Theory::Pitch.new(note: 'F',  octave: 3).integer).to eq(53)
  end

  it 'can be created by number' do
    expect(Theory::Pitch[12].name).to eq('C0')
    expect(Theory::Pitch[13].name).to eq('C#0')
    expect(Theory::Pitch[69].name).to eq('A4')
    expect(Theory::Pitch[53].name).to eq('F3')
    expect(Theory::Pitch[56].name).to eq('G#3')
  end

  it 'can return frequencies' do
    expect(Theory::Pitch['C3'].frequency).to  eq(130.8127826502993)
    expect(Theory::Pitch['C4'].frequency).to  eq(261.6255653005986)
    expect(Theory::Pitch['C5'].frequency).to  eq(523.2511306011972)
    expect(Theory::Pitch['A4'].frequency).to  eq(440.0)
    expect(Theory::Pitch['C1'].frequency).to  eq(32.70319566257483)
    expect(Theory::Pitch['D2'].frequency).to  eq(73.4161919793519)
    expect(Theory::Pitch['G#3'].frequency).to eq(207.65234878997256)
  end

  it 'can perform math operations' do
    expect(Theory::Pitch['C3'] + 2).to  eq(Theory::Pitch['D3'])
    expect(Theory::Pitch['C3'] + 12).to eq(Theory::Pitch['C4'])
    expect(Theory::Pitch['C3'] + 24).to eq(Theory::Pitch['C5'])
    expect(Theory::Pitch['C3'] + 0).to  eq(Theory::Pitch['C3'])
    expect(Theory::Pitch['C3'] - 0).to  eq(Theory::Pitch['C3'])
    expect(Theory::Pitch['C3'] - 1).to  eq(Theory::Pitch['B2'])
    expect(Theory::Pitch['C3'] - 12).to eq(Theory::Pitch['C2'])
  end

  it 'can return the pitch class' do
    expect(Theory::Pitch['G#3'].pitch_class).to eq(Theory::PitchClass['G#'])
  end

  it 'can return the octave' do
    expect(Theory::Pitch['G#3'].octave).to eq(3)
  end
end
