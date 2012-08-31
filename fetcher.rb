# -*- coding: utf-8 -*-

require 'rubygems'
require 'mechanize'

class Fetcher
  def initialize
    @agent = Mechanize.new
  end

  def fetch(dir)
    @agent.get 'http://t-proj.com/twitter/?q=from%3Akotoriko+%40todesking'
    @agent.page.search('//div[@class="twitter_status"]').each do |status|
      next if status.has_attribute?('style')
      status.to_s =~ /http:\/\/twitter\.com\/intent\/retweet\?tweet_id=(\d+)/
      id = $1
      status.inner_text =~ /(.+)From: kotoriko/
      text = $1
      p id
      open(dir + id + '.txt', 'w') do |f|
        f.write(text)
      end
    end
  end
end

if __FILE__ == $0
  Fetcher.new.fetch(ARGV[0])
end
