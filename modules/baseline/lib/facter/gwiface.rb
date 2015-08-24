# Unreliable

Facter.add("gwiface") do
  setcode do
    kernel = Facter.value(:kernel)
    case kernel
    when "FreeBSD"
        Facter::Util::Resolution.exec('/usr/bin/netstat -nr | /usr/bin/awk \'/default/ {print $4}\' | head -n 1')
    when "Linux"
        Facter::Util::Resolution.exec('/sbin/ip route |awk \'/default/ {print $5}\'')
    end
  end
end

