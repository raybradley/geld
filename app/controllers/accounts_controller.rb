class AccountsController < ApplicationController
  before_action :find_account, only: [:show]

  def show
    from_date  = 3.weeks.ago
    until_date = 3.month.from_now

    @current_family   = current_family
    @starting_balance = @account.balance_on(target_date: from_date)
    @transactions     = @account.all_transactions(
      from_date:  from_date,
      until_date: until_date
    )

    @daily_balances = @account.balance_over_time(
      from_date:  from_date,
      until_date: until_date
    )    
  end

  def create
    current_family.accounts.create(account_params)
    redirect_to :root
  end

  private

  def account_params
    params.require(:account).permit(:name)
  end

  def find_account
    @account = current_family.accounts.find(params[:id])
  end
end
