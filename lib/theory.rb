# frozen_string_literal: true

# The main module for working with Music Theory
module Theory
  require 'dry-monads'
  require 'theory/theory_error'
  autoload :Frequency, 'theory/frequency'

  BASE_OCTAVE = 4
  BASE_PITCH_INTEGER = 9

  def self.tuning=(f)
    @base_tuning = Frequency[f].octave(-4)
  end

  def self.base_tuning
    @base_tuning
  end

  @base_tuning = Frequency[440].octave(-4)

  autoload :Pitch,                  'theory/pitch'
  autoload :Voicing,                'theory/voicing'

  autoload :PitchClass,             'theory/pitch_class'
  autoload :Note,                   'theory/note'
  autoload :NoteSet,                'theory/note_set'

  autoload :FrequencyInterval,      'theory/frequency_interval'
  autoload :IntervalClass,          'theory/interval_class'
  autoload :Interval,               'theory/interval'
  autoload :UnorderedIntervalClass, 'theory/unordered_interval_class'
  autoload :IntervalSequence,       'theory/interval_sequence'
  autoload :Qualities,              'theory/qualities'
  autoload :ChordQuality,           'theory/chord_quality'
  autoload :Chord,                  'theory/chord'
  autoload :ChordSubstitutions,     'theory/chord_substitutions'
  autoload :RomanChord,             'theory/roman_chord'

  autoload :ClassicScales,          'theory/classic_scales'
  autoload :Scale,                  'theory/scale'
  autoload :ScaleSet,               'theory/scale_set'
  autoload :CircleOfFifths,         'theory/circle_of_fifths'
  autoload :DiatonicScale,          'theory/diatonic_scale'
  autoload :GreekMode,              'theory/greek_mode'
  autoload :Key,                    'theory/key'

  autoload :NotableProgressions,    'theory/notable_progressions'
  autoload :Changes,                'theory/changes'
  autoload :Cadence,                'theory/cadence'
  autoload :ProgressionSet,         'theory/progression_set'
  autoload :Progression,            'theory/progression'
  autoload :Mode,                   'theory/mode'
end
