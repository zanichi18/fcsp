class ArrayJob
  class << self
    def get_job job_object, user_object
      arr_job = Array.new
      job_object.select do |job|
        arr_job << job unless (user_object.skills & job.skills).empty?
      end
      arr_job
    end
  end
end
