# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "/var/www/gravure-tube/current/log/cron.log"
set :environment, :production
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 6.hours do
  rake "rss:create_video"
end

every 1.hours do
  rake "monitoring:delete_banned_video"
end

every 1.days do
  rake "sitemap:refresh"
end

every '30 0-23/3 *  *  *' do
  rake "buffer:create_video"
end

every '30 0-23/4 *  *  *' do
  rake "buffer:create_dmm_adult_ad"
end
