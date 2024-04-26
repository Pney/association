class ActivePeopleService
  def self.call
    {
      active: Person.active.count,
      inactive: Person.inactive.count
    }
  end
end
