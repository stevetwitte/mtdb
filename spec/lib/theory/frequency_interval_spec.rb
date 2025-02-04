# frozen_string_literal: true

RSpec.describe Theory::Interval do
  it 'can detect if ascending or descending' do
    expect(Theory::Frequency[440] / Theory::Frequency[480]).to be_ascending
    expect(Theory::Frequency[480] / Theory::Frequency[410]).to_not be_ascending
    expect(Theory::Frequency[999] / Theory::Frequency[480]).to be_descending
    expect(Theory::Frequency[100] / Theory::Frequency[410]).to_not be_descending
    expect(Theory::Frequency[440] / Theory::Frequency[440]).to_not be_ascending
    expect(Theory::Frequency[440] / Theory::Frequency[440]).to_not be_descending
  end
end
