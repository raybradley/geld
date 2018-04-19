class TransactionsController < ApplicationController
  before_action :find_transaction, except: :index

  def show
  end

  def update
    @transaction.update_attributes(transaction_params)
  end

  private

  def find_transaction
    @transaction = current_family.transactions.find(params[:id])
  end

  def transaction_params
    params.permit(:transaction).require(:amount)
  end
end
