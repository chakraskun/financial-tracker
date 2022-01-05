module Userable extend ActiveSupport::Concern
  def user
    return @user
  end

  def setup_user
    @user = User.find_by(id: self.user_id)
  end
end