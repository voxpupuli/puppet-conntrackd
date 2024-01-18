# frozen_string_literal: true

# get the value of /proc/sys/net/netfilter/nf_conntrack_max
f = ['/proc/sys/net/netfilter/nf_conntrack_max',
     '/proc/sys/net/ipv4/ip_conntrack_max'].find { |file| File.exist?(file) }

Facter.add('nf_conntrack_max') do
  confine kernel: :linux
  confine { !f.nil? }

  setcode do
    File.read(f).chomp.to_i
  rescue StandardError => e
    Facter.warn(e)
    nil
  end
end
