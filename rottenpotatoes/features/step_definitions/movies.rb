Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    current_movie = Movie.new
    current_movie.title = movie[:title]
    current_movie.rating = movie[:rating]
    current_movie.release_date = movie[:release_date]
    current_movie.director = movie[:director]
    current_movie.save!
  end
end

Then /^the director of "(.*)" should be "(.*)"/ do |title, director|
  expect(Movie.select('title', 'director').where(title: title).first.director).to eq(director)
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  order = {e1 => '', e2 => ''}
a = Regexp.new("^(#{e1.gsub(/\s+/, '\s')})\\s*.*")
b = Regexp.new("^(#{e2.gsub(/\s+/, '\s')})\\s*.*")
  page.all('table#movies tbody tr').each do | td|
      order[e1] = td.path.match(/.*\[(\d+)\]$/)[1] unless td.text.match(a).nil?
      order[e2] = td.path.match(/.*\[(\d+)\]$/)[1] unless td.text.match(b).nil?
  end
  expect(order[e1].to_i).to be < order[e2].to_i
end

When /^(?:|I )check ratings "([^"]*)"$/ do |field|
  check("ratings[#{field}]")
end

When /^(?:|I )uncheck ratings "([^"]*)"$/ do |field|
  uncheck("ratings[#{field}]")
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do | rating|
    uncheck("ratings[#{rating}]") if uncheck
    check("ratings[#{rating}]") if !uncheck
  end 
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  total = Movie.count(:title)
  expect(page.all('table#movies tbody tr').count).to eq (total)
end
