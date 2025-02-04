# frozen_string_literal: true

module Theory
  # Musical scale creation and manipulation
  class Scale
    extend ClassicScales
    extend Forwardable

    def_delegators :notes, :accidentals, :sharps, :flats

    attr_reader :interval_sequence, :tone

    def initialize(*relative_intervals, tone: 'C',
                    mode: 1,
                    name: nil,
                    notes: nil)
      @name = name
      if relative_intervals.any? && tone
        @tone              = Note[tone]
        relative_intervals = relative_intervals.rotate(mode - 1)
        @interval_sequence = IntervalSequence.new(
          relative_intervals: relative_intervals
        )
      elsif notes
        @notes             = NoteSet[*notes]
        @tone              = @notes.first
        ds                 = @notes.interval_sequence.relative_intervals
        @interval_sequence = IntervalSequence.new(relative_intervals: ds)
      else
        raise WrongKeywordsError,
              '[*relative_intervals, tone: "C", mode: 1] || [notes:]'
      end
    end

    def id
      [(name || @interval_sequence), tone.number]
    end

    def ==(other)
      id == other.id
    end

    def name
      @name ||= begin
        is = interval_sequence.relative_intervals
        (0...is.size).each do |i|
          if (scale_name = ClassicScales::SCALES.key(is.rotate(i)))
            return scale_name
          end
        end
        nil
      end
    end

    def full_name
      "#{tone} #{name}"
    end

    alias to_s full_name

    def pretty_name
      "#{tone.pretty_name} #{name}"
    end

    alias full_name pretty_name

    def degree(d)
      raise WrongDegreeError, d if d < 1 || d > size
      tone + interval_sequence[d - 1].semitones
    end

    alias [] degree

    def degrees
      (1..size)
    end

    def degree_of_chord(chord)
      return if chords(chord.size).map(&:name).include?(chord.name)
      degree_of_note(chord.root_note)
    end

    def degree_of_note(note)
      notes.index(note)
    end

    def &(other)
      raise HasNoNotesError unless other.respond_to?(:notes)
      notes & other
    end

    def include_notes?(arg)
      noteset = arg.is_a?(Note) ? NoteSet[arg] : arg
      (self & noteset).size == noteset.size
    end

    alias include? include_notes?

    def notes
      @notes ||= NoteSet[*degrees.map { |d| degree(d) }]
    end

    def interval(i)
      interval_sequence[(i - 1) % size]
    end

    def size
      interval_sequence.size
    end

    def tertians(n = 3)
      degrees.size.times.reduce([]) do |memo, d|
        ns = NoteSet[ *Array.new(n) { |i| notes[(d + (i * 2)) % size] } ]
        begin
          chord = Chord.new(notes: ns)
        rescue ChordNotFoundError
          memo
        else
          memo + [chord]
        end
      end
    end

    def triads
      tertians(3)
    end

    def sevenths
      tertians(4)
    end

    def pentads
      tertians(5)
    end

    def progression(*degrees)
      Progression.new(self, degrees)
    end

    def chords(size = 3..12)
      size = (size..size) if size.is_a?(Integer)
      scale_rotations = interval_sequence.inversions
      ChordQuality.intervals_per_name.reduce([]) do |memo1, (qname, qintervals)|
        next memo1 unless size.include?(qintervals.size)
        memo1 + scale_rotations.each_with_index
                                .reduce([]) do |memo2, (rot, index)|
                  if (rot & qintervals).size == qintervals.size
                    memo2 + [Chord.new(root_note: degree(index + 1),
                                        quality: ChordQuality.new(name: qname))]
                  else
                    memo2
                  end
                end
      end
    end

    alias all_chords chords
  end
end
