Given /^I run rmsgen$/ do
  When %{I run `rmsgen -c config.yml` interactively}
end
