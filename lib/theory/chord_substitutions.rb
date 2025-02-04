# frozen_string_literal: true

module Theory
  module ChordSubstitutions
    def tritone_substitution
      self + Interval.augmented_fourth
    end
  end
end
