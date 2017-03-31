module Supports::Education
  class Training
    attr_reader :techniques, :trainings

    def initialize param_training, param_technique, param_page
      @param_training ||= param_training
      @param_technique = param_technique
      @param_page = param_page
    end

    def techniques
      Education::Technique.all
    end

    def search
      @search = Education::Training.search @param_training
    end

    def trainings
      trainings = if @param_technique
                    Education::Training.filter_by_technique @param_technique
      else
        Education::Training.search(name_cont: @param_training).result
      end
      trainings.newest.includes(:techniques).page(@param_page)
        .per Settings.education.trainings.per_page
    end
  end
end
