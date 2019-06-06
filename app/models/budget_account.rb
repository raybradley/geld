# this is a kind of "virtual account" into which
# funds can be classified

class BudgetAccount < AssetAccount
  def virtual_account
    true
  end
end
