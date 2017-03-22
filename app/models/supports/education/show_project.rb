module Supports::Education
  class ShowProject
    attr_reader :project, :comments

    def initialize project, comments
      @project = project
      @comments = comments
    end

    def project_members
      @project.members.order(:position).includes :user
    end

    def relations
      Education::Project.relation_plat_form(@project.plat_form)
        .newest.includes(:images).limit Settings.education.related_project.limit
    end

    def rand_project
      Education::Project.last.id
    end
  end
end
