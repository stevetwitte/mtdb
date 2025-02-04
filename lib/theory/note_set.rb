# frozen_string_literal: true

module Theory
  # It describes a set of notes
  class NoteSet
    extend Forwardable

    def_delegators :@notes, :first, :each, :size, :map, :reduce, :index,
                    :[], :index, :empty?, :permutation, :include?, :<<, :any?,
                    :count, :rotate

    attr_reader :notes

    alias root first
    alias all notes

    def self.[](*notes)
      new(notes)
    end

    def initialize(arg)
      @notes =
        case arg
        when NoteSet then arg.notes
        when Array   then arg.compact.map { |n| n.is_a?(PitchClass) ? n : Note[n] }.uniq
        else raise InvalidNotesError, arg
        end
    end

    def ==(other)
      (self & other).size == self.size
    end

    alias eql? ==

    def &(other)
      NoteSet[*(notes & other.notes)]
    end

    def degree(note)
      index(note) + 1
    end

    def +(other)
      case other
      when Note then NoteSet[*(notes + [other])]
      when NoteSet then NoteSet[*notes, *other.notes]
      when Interval then NoteSet[*notes.map { |n| n + other }]
      end
    end

    def -(other)
      case other
      when NoteSet then NoteSet[*(notes - other.notes)]
      when Interval then NoteSet[*notes.map { |n| n - other }]
      end
    end

    def pretty_names
      map(&:pretty_name)
    end

    def names
      map(&:name)
    end

    def hash
      integers.join.to_i
    end

    def integers
      map(&:integer)
    end

    def accidentals
      count(&:accidental?)
    end

    def sharps
      count(&:sharp?)
    end

    def flats
      count(&:flat?)
    end

    def alter(alteration)
      NoteSet[*map { |n| n.alter(alteration) }]
    end

    def alter_accidentals(alteration)
      NoteSet[*map { |n| n.alter(alteration) if n.accidental? }]
    end

    def interval_sequence
      IntervalSequence.new(notes: self)
    end
  end
end
