module ApplicationHelper 
  def date_to_string(date)
    "#{date.strftime('%B %-d, %Y')}" if date
  end
end
