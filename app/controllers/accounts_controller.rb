class AccountsController < FamilyContextController
  before_action :find_account, only: [:show]

  def show
    @additional_classes = "#{@account.type.downcase}-account"
    @color = 'rgb(247, 185, 0)' if @account.is_a? CheckingAccount
    @color = 'rgb(0, 116, 240)' if @account.is_a? CreditCardAccount
    find_transactions_and_balances
  end

  def new
    @account = @family.accounts.new(type: params[:type])
  end

  def create
    @account = @family.accounts.new(account_params)
    @account.save
    @account.transactions.create(
      description: 'Initial balance',
      occurred_at: Time.now,
      amount: params[:initial_balance].to_f
    )
    redirect_to @account
  end

  private

  def account_params
    params.require(:account).permit(:name, :type)
  end

  def find_account
    @account = Account.find(params[:id])
    @account = nil if @account.family != current_family
  end
end
