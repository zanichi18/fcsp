module Education::ProjectsHelper
  def split_array array_technique
    array_temp = array_technique
      .each_slice(Settings.education.projects.split_array).to_a
    if array_temp.size < Settings.education.projects.min_array_size
      return array_temp
    end
    array_technique_show = array_temp.delete_at(0)
    array_technique_hide = array_temp.flatten
    [array_technique_show, array_technique_hide]
  end
end
