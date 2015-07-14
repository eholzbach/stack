# Unreliable

Facter.add("gateway") do
  setcode do
    kernel = Facter.value(:kernel)
    case kernel
    when "FreeBSD"
        Facter::Util::Resolution.exec('/usr/bin/netstat -nr | /usr/bin/awk \'/default/ {print $2}\'')
    when "Linux"
        Facter::Util::Resolution.exec('/sbin/ip route |awk \'/default/ {print $3}\'')
    end
  end
end

