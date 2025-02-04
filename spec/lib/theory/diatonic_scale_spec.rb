# frozen_string_literal: true

RSpec.describe Theory::DiatonicScale do
  it 'has a relative minor' do
    expect(Theory::Scale.major('C').relative_minor.notes.first.name).to eq('A')
    expect(Theory::Scale.major('C').relative_minor.notes.names)
      .to contain_exactly *%w[A B C D E F G]

    expect(Theory::Scale.minor('A').relative_minor.notes.first.name).to eq('A')
    expect(Theory::Scale.minor('A').relative_minor.notes.names)
      .to contain_exactly *%w[A B C D E F G]
  end

  it 'has a relative major' do
    expect(Theory::Scale.minor('A').relative_major.notes.first.name).to eq('C')
    expect(Theory::Scale.minor('A').relative_major.notes.names)
      .to contain_exactly *%w[C D E F G A B]

    expect(Theory::Scale.major('C').relative_major.notes.first.name).to eq('C')
    expect(Theory::Scale.major('C').relative_major.notes.names)
      .to contain_exactly *%w[C D E F G A B]
  end

  it 'outputs sharps and flats that comply with music standards' do
    expect(Theory::Scale.major('C#').notes.names).to eq(%w[C# D# E# F# G# A# B#])
    expect(Theory::Scale.major('Cb').notes.names).to eq(%w[Cb Db Eb Fb Gb Ab Bb])
    expect(Theory::Scale.major('Db').notes.names). to eq(%w[Db Eb F Gb Ab Bb C])
    expect(Theory::Scale.major('F#').notes.names).to eq(%w[F# G# A# B C# D# E#])
    expect(Theory::Scale.major('Ab').notes.names).to eq(%w[Ab Bb C Db Eb F G])
    expect(Theory::Scale.minor('B').notes.names).to eq(%w[B C# D E F# G A])
    expect(Theory::Scale.minor('E').notes.names).to eq(%w[E F# G A B C D])
    expect(Theory::Scale.minor('A#').notes.names).to eq(%w[A# B# C# D# E# F# G#])
    expect(Theory::Scale.minor('G#').notes.names).to eq(%w[G# A# B C# D# E F#])
  end
end
