class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    from_date  = 2.weeks.ago
    until_date = 3.month.from_now

    @current_family   = current_family
    @starting_balance = @current_family.balance_on(target_date: from_date)
    @transactions     = @current_family.all_transactions(
      from_date: from_date,
      until_date: until_date
    )

    @daily_balances = @current_family.balance_over_time(
      from_date: from_date,
      until_date: until_date
    )
  end
end
