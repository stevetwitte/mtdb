# frozen_string_literal: true

RSpec.describe Theory::Key do
  it 'can parse and return Keys' do
    expect(Theory::Key['A#m'].name).to eq('Natural Minor')
    expect(Theory::Key['A#m'].tone.name).to eq('A#')

    expect(Theory::Key['Bb'].name).to eq('Major')
    expect(Theory::Key['Bb'].tone).to eq(Theory::Note['A#'])

    expect(Theory::Key['DM'].name).to eq('Major')
    expect(Theory::Key['DM'].tone.name).to eq('D')

    expect(Theory::Key['Dm'].name).to eq('Natural Minor')
    expect(Theory::Key['Dm'].tone.name).to eq('D')
  end
end
