env :PATH, ENV['PATH']
set :output, "log/cron.log"

#Sets the environment to run during development mode
set :environment, "development"

every 1.day, at: '10:00 AM' do
  runner "Event.reminder_sms"
end