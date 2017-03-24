module Supports::Education
  class ShowCourse
    attr_reader :user_ids, :added_users, :users

    def initialize params, course
      @params = params
      @course = course
    end

    def user_ids
      user_ids_temp = []
      if @params[:user_ids].present?
        @params[:user_ids].each do |id|
          user_ids_temp << id.to_i
        end
      end
      user_ids_temp
    end

    def added_users
      @course.users.search(name_or_email_cont:
        @params[:search_added_users]).result
    end

    def users
      User.not_in_course(@course)
        .search(name_or_email_cont: @params[:user_search]).result
    end
  end
end
