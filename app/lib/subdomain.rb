class Subdomain
  def self.matches?(request)

    case request.host
    when Setting.host, "www.#{Setting.host}", nil
      false
    else
      true
    end
  end

end
