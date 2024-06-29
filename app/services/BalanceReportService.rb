require 'csv'

class BalanceReportService
  def self.create_csv
    peoples = Person.order(:name).limit(80)
    CSV.generate do |csv|
      csv << ['Name', 'Balance']
      peoples.each do |person|
        csv << [person[:name], person[:balance]]
      end
    end
  end
end