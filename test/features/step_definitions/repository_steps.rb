require 'cucumber'
require 'date'
require './features/support/url_generator'
include GitHub

Given(/^github repo for user (.*)$/) do |user|
  GitHub.username = user
end

Given(/^endpoint for (.*) request for (\w+)(?: with (.*) "(.*)")*$/) do |path, repo, parameter, value|
  @endpoint = GitHub::get_endpoint(path, repo)
  if value or parameter
    @endpoint += GitHub::add_parameters({value => parameter})
  end
end

When(/^with (.*) "(.*)"$/) do |parameter, value|
  @endpoint += GitHub::add_parameters({value => parameter})
end


Then(/^I make api call$/) do
  @resp = GitHub::api_call(@endpoint)

end

Then(/^I should receive response with (\d+) status/) do |code|
  expect(@resp.code).to eq code.to_i
end

And(/^I should receive array of .*/) do
  resp = JSON.parse(@resp)
  expect(resp.class).to be Array
end

And(/^I should receive empty array/) do
  resp = JSON.parse(@resp)
  expect(resp.class).to be_empty
end

And(/^each \w+ should be a Hash/) do
  resp = JSON.parse(@resp)
  resp.each do |commit|
    expect(commit.class).to be Hash
  end
end

And(/^each \w+ should have all required fields:/) do |fields|
  fields = fields.raw[0]
  resp = JSON.parse(@resp)
  resp.each do |commit|
    fields.each do |field|
      expect(commit).to include field
    end
  end
end

Then(/^each commit has (.*) as author email$/) do |author|
  resp = JSON.parse(@resp)
  resp.each do |commit|
    expect(commit['commit']['author']['email']).to eq author
  end
end

Then(/^all commits should be pushed after (.*) date$/) do |date|
  resp = JSON.parse(@resp)
  resp.each do |commit|
    expect(Date.parse(commit['commit']['author']['date'])).to be > Date.parse(date)
  end
end

Then(/^all commits should be pushed before (.*) date$/) do |date|
  resp = JSON.parse(@resp)
  resp.each do |commit|
    expect(Date.parse(commit['commit']['author']['date'])).to be < Date.parse(date)
  end
end

Then(/^all commits should be done for (.*) file$/) do |file|
  resp = JSON.parse(@resp)
  resp.each do |commit|
    tree = GitHub::get_tree(commit['commit']['tree']['url'])
    expect(tree['tree'].select{|f| f['path'] == file }.size).to eq 1
  end
end

Then(/^first commit sha should be eqaul (.*)$/) do |sha|
  resp = JSON.parse(@resp)
  expect(resp[0]['sha']).to eq sha
end