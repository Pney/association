class PersonMailer < ApplicationMailer

  def balance_report(user)
    attachments['balances.csv'] = {
      mime_type: 'text/csv',
      content: BalanceReportService.create_csv
    }

    mail(to: user.email, subject: 'Relatório de Saldos')
  end
end
