Rails.backtrace_cleaner.remove_silencers!
Rails.backtrace_cleaner.add_silencer { |line| !line.start_with?(Rails.root.to_s + "/app") }
