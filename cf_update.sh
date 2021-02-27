!/bin/bash
auth_bearer="X" #API TOKEN - https://developers.cloudflare.com/api/tokens/create
dns_zone="X" #Zone record
dns_record="X" # record id to update

domain="domain.example.com" #subdomain

current_record=$(dig $domain +short)
current_ip=$(curl -s http://ifconfig.co)

proxied="false" #disable or enable CF proxy

if [[ "$current_ip" != "$current_record" ]]
then
    curl -X PUT "https://api.cloudflare.com/client/v4/zones/$dns_zone/dns_records/$dns_record" -H "Authorization: Bearer $auth_bearer" -H "Content-Type:application/json" --data '{"type":"A","name":"'$domain'","content":"'$current_ip'","ttl":1,"proxied":'$proxied'}'
else
    continue
fi
