class AccountsController < ApplicationController
  def create
    current_family.accounts.create(account_params)
    redirect_to :root
  end

  private

  def account_params
    params.require(:account).permit(:name)
  end
end
