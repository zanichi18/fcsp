module Supports
  class Candidate
    attr_reader :company

    def initialize company
      @company = company
    end

    def candidates
      @company.candidates.includes(:user, :job)
    end
  end
end
