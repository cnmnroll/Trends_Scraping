require 'open-uri'
require 'nokogiri'

urls = ['http://www.google.co.jp/trends/hottrends/atom/hourly','http://searchranking.yahoo.co.jp/rss/rt_ranking-rss.xml', 'http://twittrend.info/']
doc = [];
urls.each_index do |idx|
	charset = nil
	html = open(urls[idx]) do |f|
		charset = f.charset
		f.read
	end
	doc[idx] = Nokogiri::HTML.parse(html, nil, charset)
end

p 'Google Trends'
doc[0].css('//.Medium a').first(5).each do |obj|
	p obj.text
end

puts "\nYahoo Trends"
doc[1].css('//item title').first(5).each do |obj|
	p obj.text
end

puts "\nTwitter Japan Trends"
doc[2].css('//#japan li').first(5).each do |obj|
	p obj.text.split(' ')[1]
end

