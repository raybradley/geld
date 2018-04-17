class RecurringTransactionsController < ApplicationController
  def show
    @recurring_transaction = current_family.recurring_transactions.find(params[:id])
  end
end
