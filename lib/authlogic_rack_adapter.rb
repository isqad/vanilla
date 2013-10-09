require 'authlogic/controller_adapters/rack_adapter'

class AuthlogicRackAdapter < Authlogic::ControllerAdapters::RackAdapter
  def cookie_domain
    controller.host
  end

  def cookies
    c = controller.cookies.map do |key, value_hash|
      if value_hash.is_a?(Hash) && value_hash.has_key?(:value)
        {key => value_hash[:value]}
      elsif value_hash.is_a?(String)
        {key => value_hash}
      end
    end
    c = c.inject(:merge) || {}
  end
end