class ReportsController < ApplicationController
  def balance
    PersonMailer.balance_report(current_user).deliver_later
    redirect_to root_path, notice: 'Relatório enviado para seu e-mail'
  end
end
