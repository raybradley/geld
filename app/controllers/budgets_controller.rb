class BudgetsController < FamilyContextController
  def index
    @budgets = @family.budgets
  end
end
