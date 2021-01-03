require 'open3'
require 'shellwords'
require 'discordrb'
def self.pass
   stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.password) | .password'  | sort | uniq -c | sort -bgr | head -10 })
stdout.to_s
end
def self.user
   stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.username) | .username'  | sort | uniq -c | sort -bgr | head -10 })
stdout.to_s
end

def self.tcp_ip
   stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.eventid | contains("cowrie.direct-tcpip.request")) .dst_ip' | sort | uniq -c | sort -bgr | head -n 10 })
stdout.to_s
end

def self.pass_all
    stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.password) | .password' })
stdout.to_s
end
def self.user_all
   stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.username) | .username' })
stdout.to_s
end


def self.top_ip
    stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.password) | .src_ip'  | sort | uniq -c | sort -bgr | head -10 })
stdout.to_s
end
def self.top_user
    stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.username) | .username'  | sort | uniq -c | sort -bgr | head -10 })
stdout.to_s
end
def self.top_pass
    stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.password) | .password'  | sort | uniq -c | sort -bgr | head -10 })
stdout.to_s
end
def self.top_commands
     stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.eventid | contains("cowrie.command.input")) | .input' | sort | uniq -c | sort -bgr | head -n 10 })
stdout.to_s
end
def self.top_f_ip
   stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.eventid | contains("cowrie.login.failed")) .src_ip' | sort | uniq -c | sort -bgr | head -n 10 })
stdout.to_s
end
def self.top_s_ip
   stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.eventid | contains("cowrie.login.success")) .src_ip' | sort | uniq -c | sort -bgr | head -n 10 })
stdout.to_s
end
def self.top_f_pass
    stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.eventid | contains("cowrie.login.failed")) .password' | sort | uniq -c | sort -bgr | head -n 10 })
stdout.to_s
end
def self.top_s_pass
    stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.eventid | contains("cowrie.login.success")) .password' | sort | uniq -c | sort -bgr | head -n 10 })
stdout.to_s
end
def self.top_f_user
    stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.eventid | contains("cowrie.login.failed")) .username' | sort | uniq -c | sort -bgr | head -n 10 })
stdout.to_s
end
def self.top_s_user
    stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.eventid | contains("cowrie.login.success")) .username' | sort | uniq -c | sort -bgr | head -n 10 })
stdout.to_s
end
def self.top_commands
     stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.eventid | contains("cowrie.command.input")) | .input' | sort | uniq -c | sort -bgr | head -n 10 })
stdout.to_s
end
def self.top_download
     stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.eventid | contains("cowrie.session.file_download")) | .destfile' |  grep -v "null" | sort | uniq -c | sort -bgr | head -n 10 })
stdout.to_s
end


def self.pass
     stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.password) | .password' })
stdout.to_s
end
def self.export_comamnds
    stdout, status = Open3.capture2(%q{ cat cowrie.json* | jq '. | select(.eventid | contains("cowrie.command.input")) | .input' > out_comamnds.txt })
end
def self.export_pass
    stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.password) | .password' | > out_pass.txt})
end
def self.export_user
    stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.username) | .username' | > out_username.txt})
end
def self.export_ip
    stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.src_ip) | .src_ip' | > out_ip.txt})
end
def self.export_download
    stdout, status = Open3.capture2(%q{cat cowrie.json* | jq '. | select(.eventid | contains("cowrie.session.file_download")) | .destfile' > out_download.txt})
end


bot = Discordrb::Commands::CommandBot.new token: '', client_id:  id, prefix: '.'



bot.command(:pass) do |event, id|
    if id.to_s == "top"
        event.respond(top_pass)
    elsif id.to_s == "s"
        event.respond(top_s_pass)
    elsif id.to_s == "f"
        event.respond(top_f_pass)
    elsif id.to_s == "e"
        export_pass
        event.send_file(File.open("out_pass.txt"))
    end
end
bot.command(:user) do |event, id|
    if id.to_s == "top"
         event.respond(top_user)
    elsif id.to_s == "s"
        event.respond(top_s_pass)
    elsif id.to_s == "f"
        event.respond(top_f_pass)
    elsif id.to_s == "e"
        export_pass
        event.send_file(File.open("out_user.txt"))
    end
end

bot.command(:ip) do |event, id|
    if id.to_s == "top"
        event.respond(top_ip)
    elsif id.to_s == "s"
        event.respond(top_s_ip)
    elsif id.to_s == "f"
        event.respond(top_f_ip)
   elsif id.to_s == "tcp"
        event.respond(tcp_ip)
    elsif id.to_s == "e"
        export_ip
        event.send_file(File.open("out_ip.txt"))
    end
end


bot.command(:commands) do |event, id|
    if id.to_s == "top"
        event.respond(top_commands)
    elsif id.to_s == "e"
        export_comamnds
        event.send_file(File.open("out_commands.txt"))
    end
end

bot.command(:download) do |event, id|
    if id.to_s == "top"
        event.respond(top_download)
    elsif id.to_s == "e"
        export_download
        event.send_file(File.open("out_download.txt"))
    end
end

bot.run
