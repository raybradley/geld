class AccountsController < ApplicationController
  before_action :find_account, only: [:show]
  before_action :find_current_family

  def show
    @additional_classes = "#{@account.account_type}-account"
    @color = 'rgb(247, 185, 0)' if @account.account_type == 'checking'
    @color = 'rgb(0, 116, 240)' if @account.account_type == 'credit_card'
    find_transactions_and_balances
  end

  def new
    @account = current_family.accounts.new(account_type: params[:account_type].to_sym)
  end

  def create
    @account = @current_family.accounts.new(account_params)
    @account.save
    @account.transactions.create(
      description: 'Initial balance',
      occurred_at: Time.now,
      amount: params[:initial_balance].to_f
    )
    redirect_to @account
  end

  private

  def find_current_family
    @current_family = current_family
  end

  def account_params
    params.require(:account).permit(:name, :account_type)
  end

  def find_account
    @account = Account.find(params[:id])
    @account = nil if @account.family != current_family
  end
end
