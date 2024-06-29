module PersonHelper
  def active_status(person)
    if person.active
      '<span class="text-success"> <i class="bi bi-check-circle"></i> </span>'.html_safe
    else
      '<span class="text-danger"> <i class="bi bi-x-circle"></i> </span>'.html_safe
    end
  end
end