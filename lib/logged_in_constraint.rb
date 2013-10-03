class LoggedInConstraint
  include Concerns::AuthlogicConcern
=begin
  def initialize(request)
    request.instance_eval do
      def request; self; end
      def remote_ip; self.ip; end
    end
    Authlogic::Session::Base.controller = Authlogic::ControllerAdapters::AbstractAdapter.new(request)
  end
=end

  def self.matches?(request)
    #raise RuntimeError, new.send(:current_user).inspect
    new.send(:current_user).present?
  end
end