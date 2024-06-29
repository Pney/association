class LatestDebtsWithPerson
  def initialize()
  end

  def call
    request_latest_debts
  end

  private

  def request_latest_debts
    @debts = Debt.includes(:person).where('amount > 100000').order(created_at: :DESC).limit(10)
    raise ArgumentError, 'Nenhum débito foi encontrado!' unless @debts.present?

    @debts
  end
end
