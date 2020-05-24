class Domains::Data::Days < BrowserAction
  param period : String = "7d"

  get "/domains/:domain_id/data/days" do
    domain = DomainQuery.new.user_id(current_user.id).find(domain_id)
    days, today, data = parse_response(domain)
    json DaysSerializer.new(days, today, data)
  end

  def parse_response(domain)
    metrics = Metrics.new(domain, period)
    metrics.get_days
  end
end
