class UserSession < Authlogic::Session::Base
  remember_me_for 1.months
end