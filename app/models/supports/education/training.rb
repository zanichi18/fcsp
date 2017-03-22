module Supports::Education
  class Training
    attr_reader :techniques, :trainings

    def initialize param_q, param_technique, param_page
      @param_q ||= param_q
      @param_technique = param_technique
      @param_page = param_page
    end

    def techniques
      Education::Technique.all
    end

    def search
      @search = Education::Training.search @param_q
    end

    def trainings
      search = Education::Training.search @param_q
      trainings = if @param_technique
                    Education::Training.filter_by_technique @param_technique
      else
        search.result(distinct: true)
      end
      trainings.newest.includes(:techniques).page(@param_page)
        .per Settings.education.trainings.per_page
    end
  end
end
