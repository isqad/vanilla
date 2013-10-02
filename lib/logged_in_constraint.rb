class LoggedInConstraint
  include Concerns::AuthlogicConcern

  def self.matches?(request)
    new.send(:current_user).present?
  end
end