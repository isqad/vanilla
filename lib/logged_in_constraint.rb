class LoggedInConstraint
  include Concerns::AuthlogicConcern

  def self.matches?(request)
    new.current_user.present?
  end
end