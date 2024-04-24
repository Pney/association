class TransactionService
  def initialize(attr)
    @person = attr[:person]
    @amount = attr[:amount]
    @action_type = attr[:action_type]
  end

  def person_balance_adjustment
    update_person_balance
  end

  private

  def update_person_balance
    raise ArgumentError, "Pessoa não encontrada para ajuste de saldo!" unless @person.present?

    balance = process_new_balance(@person.balance)
    @person.update(balance: balance)
  end

  def process_new_balance(balance)
    return balance - @amount if @action_type == 'DEBT'

    balance + @amount
  end
end
