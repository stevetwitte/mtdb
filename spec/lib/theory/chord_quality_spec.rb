# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Theory::ChordQuality do
  [
    [%w[C E G], 'M'],
    [%w[C D# G], 'm'],
    [%w[C E G#], '+'],
    [%w[C Eb F#], 'dim'],

    [%w[C D G], 'Msus2'],
    [%w[C F G], 'Msus4'],

    [%w[C E G A], 'M6'],
    [%w[C Eb G A], 'm6'],

    [%w[C E G B], 'M7'],
    [%w[C Eb G Bb], 'm7'],
    [%w[C E G Bb], '7'],
    [%w[C D# Gb Bb], 'm7b5'],
    [%w[C Eb G B], 'm(M7)'],
    [%w[C E G# Bb], '+7'],

    [%w[C E G A D], '6/9'],
    [%w[C E G B D], 'M9'],
    [%w[C E G Bb D], '9'],
    [%w[C Eb G B D], 'm(M9)'],
    [%w[C E G# B D], '+M9'],
    [%w[C E G# Bb D], '+9'],

    [%w[C Eb Gb Bb D], 'm7b5(9)'],
    [%w[C Eb Gb Bb Db], 'm7b5b9'],

    [%w[C E G Bb D F], '11'],
    [%w[C E G B D F], 'M11'],
    [%w[C Eb G B D F], 'm(M11)'],
    [%w[C E G# B D F], '+M11'],
    [%w[C E G# Bb D F], '+11']

  ].each do |row|
    it "returns #{row[1]} for #{row[0].join(',')} notes" do
      quality = Theory::ChordQuality.new(notes: row[0])
      expect(quality.name).to eq(row[1])
    end

    it "#{row[1]} for #{row[0].join(',')} returns the right notes" do
      chord = Theory::Chord.new root_note: Theory::Note['C'],
                                quality: Theory::ChordQuality.new(notes: row[0])

      expect(chord.notes.integers).to contain_exactly(*Theory::NoteSet[*row[0]].integers)
    end
  end
end
