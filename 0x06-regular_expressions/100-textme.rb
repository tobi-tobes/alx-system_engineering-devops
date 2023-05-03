#!/usr/bin/env ruby
puts ARGV[0].scan(/from:(\+?\w*)/).join + "," + ARGV[0].scan(/to:(\+?\w*)/).join + "," + ARGV[0].scan(/-?[0-1]:-?[0-1]:-?[0-1]:-?[0-1]:-?[0-1]/).join
