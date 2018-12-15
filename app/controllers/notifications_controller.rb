class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    transaction = PagSeguro::Transaction.find_by_notification_code(params[:notificationCode])

    if transaction.errors.empty?
      # Processa a notificação. A melhor maneira de se fazer isso é realizar
      # o processamento em background. Uma boa alternativa para isso é a
      # biblioteca Sidekiq.
    end

    render nothing: true, status: 200
  end
  
  def transaction_abandoned
    report = PagSeguro::Transaction.find_abandoned

    while report.next_page?
      report.next_page!
      puts "=> Page #{report.page}"
    
      abort "=> Errors: #{report.errors.join("\n")}" unless report.valid?
    
      puts "=> Report was created at: #{report.created_at}"
      puts
    
      report.transactions.each do |transaction|
        puts "=> Abandoned transaction"
        puts "   created at: #{transaction.created_at}"
        puts "   code: #{transaction.code}"
        puts "   type_id: #{transaction.type_id}"
        puts "   gross amount: #{transaction.gross_amount}"
        puts
      end
    end
  end
  
  def transaction_status
    response = PagSeguro::Transaction.find_status_history("transaction_code")

    response.each do |status|
      puts "STATUS:"
      puts "  code: #{status.code}"
      puts "  date: #{status.date}"
      puts "  notification_code: #{status.notification_code}"
    end
  end
end