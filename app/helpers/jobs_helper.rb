module JobsHelper
  def select_hiring_type
    HiringType.all.map{|key| [key.name, key.id]}
  end
end
