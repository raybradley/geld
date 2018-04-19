class RecurringTransactionsController < ApplicationController
  before_action :find_recurring_transaction

  def show
  end

  def update
    @recurring_transaction.update_attributes(recurring_transaction_params)
    @account = @recurring_transaction.account
    find_transactions_and_balances
  end

  private

  def find_recurring_transaction
    @recurring_transaction = current_family.recurring_transactions.find(params[:id])
  end

  def recurring_transaction_params
    params.require(:recurring_transaction).permit(:amount_abs)
  end
end
