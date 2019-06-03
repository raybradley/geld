class HomeController < FamilyContextController
  before_action :authenticate_user!

  def index
    from_date  = 3.weeks.ago
    until_date = 4.weeks.from_now

    @starting_balance = @family.balance_on(target_date: from_date)
    @transactions     = @family.all_transactions(
      from_date: from_date,
      until_date: until_date
    )

    @daily_balances = @family.balance_over_time(
      from_date: from_date,
      until_date: until_date
    )

    @accounts = @family.accounts
  end
end
