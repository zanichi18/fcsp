module Supports::Education
  class ShowProject
    attr_reader :project_members, :relations, :rand_project

    def initialize project_members, relations, rand_project
      @project_members = project_members
      @relations = relations
      @rand_project = rand_project
    end
  end
end
