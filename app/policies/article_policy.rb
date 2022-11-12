class ArticlePolicy < ApplicationPolicy

  def standard_check
    super
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def new?
    standard_check
  end

  def edit?
    standard_check
  end

  def create?
    standard_check
  end

  def update?
    standard_check
  end

  def destroy?
    standard_check
  end

end
