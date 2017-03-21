module Supports::Education
  class ShowProject
    attr_reader :project_members, :relations

    def initialize project_members, relations
      @project_members = project_members
      @relations = relations
    end
  end
end
