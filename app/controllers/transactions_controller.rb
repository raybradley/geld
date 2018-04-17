class TransactionsController < ApplicationController
  def show
    @transaction = current_family.transactions.find(params[:id])
  end
end
