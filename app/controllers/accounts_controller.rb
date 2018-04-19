class AccountsController < ApplicationController
  before_action :find_account, only: [:show]
  before_action :find_current_family

  def show
    @additional_classes = "#{@account.account_type}-account"
    @color = 'rgb(247, 185, 0)' if @account.account_type == 'checking'
    find_transactions_and_balances
  end

  def create
    current_family.accounts.create(account_params)
    redirect_to :root
  end

  def new
    @account = current_family.accounts.new(account_type: params[:account_type].to_sym)
  end

  def create
    @account = @current_family.accounts.new(account_params)
    @account.save
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
