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
    @active_peoples_ids ||= Rails.cache.fetch('active_people', expires_in: 10.minutes) do
      Person.active.select(:id)
    end
  end

  def total_debts_amount
    @total_debts = Rails.cache.fetch('total_debts_amount', expires_in: 10.minutes) do
      Debt.where(person_id: active_peoples).sum(:amount)
    end
  end

  def total_payments_amount
    @total_payments = Rails.cache.fetch('total_payments_amount', expires_in: 10.minutes) do
      Payment.where(person_id: active_peoples).sum(:amount)
    end
  end

  def process_balance
    @balance = Rails.cache.fetch('balance', expires_in: 10.minutes) do
      @total_payments - @total_debts
    end
  end
end
