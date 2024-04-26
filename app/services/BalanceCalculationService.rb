class BalanceCalculationService
  def initialize
  end

  def call
    total_debts_amount
    total_payments_amount

    process_balance

    [@total_debts, @total_payments, @balance]
  end

  private

  def active_peoples
    @active_peoples_ids ||= Person.active.select(:id)
  end

  def total_debts_amount
    @total_debts = Debt.where(person_id: active_peoples).sum(:amount)
  end

  def total_payments_amount
    @total_payments = Payment.where(person_id: active_peoples).sum(:amount)
  end

  def process_balance
    @balance = @total_payments - @total_debts
  end
end
