class DailyReportWorker
    include Sidekiq::Worker
  
    def perform
      purchases = Purchase.where("created_at >= ?", 1.day.ago)
      admins = Admin.all
  
      admins.each do |admin|
        generate_daily_report(purchases, admin)
      end
    end
  
    private
  
    def generate_daily_report(purchases, admin)
      AdminMailer.daily_report(purchases, admin).deliver_now
      puts "Daily report generated and sent."
    end
  end
  