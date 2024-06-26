class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_people_with_balance, only: [:index]

  def index
    @active_people_pie_chart = ActivePeopleService.call
    @total_debts, @total_payments, @balance = BalanceCalculationService.new.call
    @last_debts = LatestRecordsService.new(Debt, :id, :amount, cache_name: 'last_debts').call
    @last_biggest_debts = LatestDebtsWithPerson.new.call
    @last_payments = LatestRecordsService.new(Payment, :id, :amount, cache_name: 'last_payments').call
    @last_peoples_by_user = LatestRecordsService.new(
      Person,
      condition: { user: current_user },
      cache_name: 'last_peoples_by_user'
    ).call
    @top_person = @people.last
    @bottom_person = @people.first
  end

  private

  def set_people_with_balance
    @people = Person.where('balance > 0').order(balance: :DESC)
  end
end