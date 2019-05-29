class FamilyContextController < ApplicationController
  before_action :find_family

  def find_family
    @family = Family.first
  end  
end
