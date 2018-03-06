class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    from_date = 20.years.ago
    until_date = 3.month.from_now

    @current_family   = current_family
    @starting_balance = @current_family.balance_on(target_date: from_date)

ap @starting_balance

    @transactions     = @current_family.transactions(from_date: from_date, until_date: until_date)
  end
end
