# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'
require 'pry-debugger'

agent = Mechanize.new

agent.request_headers = { 'accept' => 'application/vnd.bountysource+json; version=2'}
# Read in a page
page = agent.get("https://api.bountysource.com/teams/crystal-lang")

# Find somehing on the page using css selectors
data = JSON.parse(page.body)

# Write out to the sqlite database using scraperwiki library
ScraperWiki.save_sqlite(["timestamp"], {
  "timestamp" => Time.now.strftime('%Y%m%d_%H%M%S'),
  "activity_total" => data['activity_total'],
  "support_level_sum" => data['support_level_sum'],
  "support_level_count" => data['support_level_count'],
  "monthly_contributions_sum" => data['monthly_contributions_sum'],
  "monthly_contributions_count" => data['monthly_contributions_count'],
})

# An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
