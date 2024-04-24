class Debt < ApplicationRecord
  belongs_to :person
  validates :amount, presence: true
  after_save :update_person_balance

  private

  def update_person_balance
    attr = {
      person: person,
      amount: amount,
      action_type: 'DEBT'
    }
    TransactionService.new(attr).person_balance_adjustment
  end
end
