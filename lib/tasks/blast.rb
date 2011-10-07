#!/usr/bin/env ruby

timestamp = ARGV.pop
blast_cmd = ARGV.pop
puts blast_cmd

system(blast_cmd)
system("mv tmp/#{timestamp}_working.txt tmp/#{timestamp}_result.txt")

