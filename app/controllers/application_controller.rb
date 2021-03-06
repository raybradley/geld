class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # assumes @account has been set
  def find_transactions_and_balances
    from_date  = 3.weeks.ago
    until_date = 4.weeks.from_now

    @starting_balance = @account.balance_on(target_date: from_date)
    @transactions     = @account.all_transactions(
      from_date:  from_date,
      until_date: until_date
    )

    @daily_balances = @account.balance_over_time(
      from_date:  from_date,
      until_date: until_date
    )

    @daily_balances.each { |k, v| @daily_balances[k] = -v } if @account.liability?
  end
end
