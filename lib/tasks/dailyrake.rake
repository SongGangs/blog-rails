# daily
# 执行命令前加上 bundle exec 比较好
namespace :morning do
  desc '任务1 关闭闹钟'
  task :trun_of_alarm do
    puts 'Turned off alarm. Would have liked 5 more minutes, though.'
  end

  desc '任务2 梳洗打扮'
  task :groom_myself do
    puts 'Brushed teeth.'
    puts 'Showered.'
    puts 'Shaved.'
  end
end

# rake afternoon:make_coffee COFFEE_CUPS=5
namespace :afternoon do
  desc '任务3 泡杯咖啡'
  task :make_coffee do
    cups = ENV['COFFER_CUPS'] || 2
    puts "Made #{cups} cups of coffee. Shakes are gone."
  end
end

namespace :everning do
  desc '任务4 遛狗'
  task :walk_dog do
    puts 'Dog walked.'
  end
end

desc '整合一天的任务'
task :ready_for_the_day do
  Rake::Task['morning:trun_of_alarm'].invoke
  Rake::Task['morning:groom_myself'].invoke
  Rake::Task['afternoon:make_coffee'].invoke
  Rake::Task['everning:walk_dog'].invoke
end

desc '今天任务'
task :today => [:ready_for_the_day] do
  puts 'end .'
end

# rake with_params_test\[song,gang\]
desc '带参数测试'
task :with_params_test, [:a, :b] do |t,args|
  puts args.inspect
  puts "params a is --  #{args.a}"
  puts "params b is --  #{args.b}"
end
