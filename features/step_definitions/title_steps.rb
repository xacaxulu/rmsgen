Then /^I should see a title for "([^"]*)"$/ do |title|
  underscored = title.gsub(' ', '_')
  date = Date.today
  datef = date.strftime('%d %B %Y')
  date_uc = datef.gsub(' ', '_')
  name = "#{date_uc}_(#{underscored})"
  anchor = "##{name}"
  html = "<p><li><a name=\'#{name}\' />#{datef} (<a class=\'titlelink\' href=\'#{anchor}\'>#{title}</a>)</p>"
  Then %{the output should contain "#{html}"}
end
