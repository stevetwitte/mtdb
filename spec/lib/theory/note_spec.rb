# frozen_string_literal: true

RSpec.describe Theory::Note do
  it 'returns an interval to other note' do
    expect(Theory::Note['C'].interval_to('D').semitones).to eq(2)
  end

  it 'when summed to intervals it returns the corresponding note' do
    expect((Theory::Note['C'] + Theory::Interval.major_third).name).to eq('E')
  end

  it 'can return intervals by subtraction' do
    expect((Theory::Note['D'] - Theory::Note['C']).name).to eq('m7')
    expect((Theory::Note['B'] - Theory::Note['C']).name).to eq('m2')
    expect((Theory::Note['C'] - Theory::Note['C']).name).to eq('P1')
  end

  it 'can be created by name' do
    expect { Theory::Note['L'].name } .to raise_error Theory::TheoryError
    expect(Theory::Note['C'].name)  .to eq('C')
    expect(Theory::Note['C#'].name) .to eq('C#')
    expect(Theory::Note['Cb'].name) .to eq('Cb')
    expect(Theory::Note['Cbb'].name). to eq('Cbb')
  end

  it 'has an alteration level' do
    expect(Theory::Note['C'].alteration)  .to eq(0)
    expect(Theory::Note['C#'].alteration) .to eq(1)
    expect(Theory::Note['Cb'].alteration) .to eq(-1)
    expect(Theory::Note['Cbb'].alteration).to eq(-2)
  end

  it 'understands enharmony' do
    expect(Theory::Note['C'])  .to eq(Theory::Note['C'])
    expect(Theory::Note['C#']) .to eq(Theory::Note['Db'])
    expect(Theory::Note['Cb']) .to eq(Theory::Note['B'])
    expect(Theory::Note['Cbb']).to eq(Theory::Note['Bb'])
    expect(Theory::Note['Cbb']).to eq(Theory::Note['A#'])
    expect(Theory::Note['E#']) .to eq(Theory::Note['F'])
    expect(Theory::Note['C'])  .to_not eq(Theory::Note['C#'])
    expect(Theory::Note['C#']) .to_not eq(Theory::Note['D'])
    expect(Theory::Note['Cb']) .to_not eq(Theory::Note['A'])
  end

  it 'can twist a note in many ways' do
    expect(Theory::Note['D#'].alter(-1).name).to    eq('Eb')
    expect(Theory::Note['D#'].alter(-2).name).to    eq('Fbb')
    expect(Theory::Note['C'].alter(-1).name).to     eq('C')
    expect(Theory::Note['C'].alter(-2).name).to_not eq('Cbb')
    expect(Theory::Note['F'].alter(+1).name).to     eq('E#')
    expect(Theory::Note['D'].alter(+2).name).to     eq('C##')
    expect(Theory::Note['D'].alter(+1).name).to     eq('D')
    expect(Theory::Note['C#'].alter(+1).name).to    eq('C#')
    expect(Theory::Note['C#'].alter(-1).name).to    eq('Db')
    expect(Theory::Note['D#'].alter(+1).name).to    eq('D#')
    expect(Theory::Note['D#'].alter(-1).name).to    eq('Eb')
    expect(Theory::Note['F#'].alter(+1).name).to    eq('F#')
    expect(Theory::Note['F#'].alter(-1).name).to    eq('Gb')
  end

  it 'can be outputted as a specific letter' do
    expect(Theory::Note['C'].as('B').name).to eq('B#')
    expect(Theory::Note['A'].as('C').name).to eq('Cbbb')
    expect(Theory::Note['B'].as('C').name).to eq('Cb')
    expect(Theory::Note['A'].as('F').name).to eq('F####')
    expect(Theory::Note['F'].as('E').name).to eq('E#')
  end
end
