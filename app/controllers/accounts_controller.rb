class AccountsController < ApplicationController
  before_action :find_account, only: [:show]
  before_action :find_current_family

  def show
    find_transactions_and_balances
  end

  def create
    current_family.accounts.create(account_params)
    redirect_to :root
  end

  private

  def find_current_family
    @current_family = current_family
  end

  def account_params
    params.require(:account).permit(:name)
  end

  def find_account
    @account = current_family.accounts.find(params[:id])
  end
end
