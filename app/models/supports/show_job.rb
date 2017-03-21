module Supports
  class ShowJob
    attr_reader :job, :company, :benefits, :members, :team_introduction,
      :hiring_types, :published_date

    delegate :benefits, to: :company, prefix: true

    def initialize job
      @job = job
    end

    def company
      @job.company
    end

    def members
      company.users
    end

    def team_introduction
      @job.team_introductions
    end

    def hiring_types
      @job.hiring_types
    end

    def published_date
      @job.created_at.to_date
    end
  end
end
