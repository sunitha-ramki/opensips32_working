goto where Dockerfile is there

make build
and on success 
make start
should see the container running

you have to run python3 setup.py install clean in ~/src/opensips-cli

you have to add line loadmodule "event_stream.so" in /etc/opensips/opensips.cfg


some opensips paths
/etc/opensips/opensips.cfg
/usr/lib/x86_64-linux-gnu/opensips/modules
/usr/share/opensips

/root/.opensips-cli.cfg


sipp 172.17.0.7 -sf register.xml -inf register_ramki.csv -i 172.17.0.4 -p 5074 -m 1 -l 1 -trace_msg -message_file uasmsg.log -trace_err -error_file uaserr.log

sipp 172.17.0.7 -sf register.xml -inf register_sunitha.csv -i 172.17.0.4 -p 5075 -m 1 -l 1 -trace_msg -message_file uasmsg.log -trace_err -error_file uaserr.lo



Note sipp -sn uac and sipp -sn uas in the below commands

sipp -sn uas -rsa 172.17.0.7:5060 -i 172.17.0.4 -p 5074

sipp -sn uac 172.17.0.7:5060 -s ramki -i 172.17.04 -p 5075 -m 1 -max_retrans 1 -trace_msg -message_file uacmsg.log -trace_err -error_file uacerr.log



Note sipp -sf uac.xml and sipp -sf uas.xml in the below commands

sipp -sn uas -rsa 172.17.0.7:5060 -i 172.17.0.4 -p 5074

sipp -sn uac 172.17.0.7:5060 -s ramki -i 172.17.04 -p 5075 -m 1 -max_retrans 1 -trace_msg -message_file uacmsg.log -trace_err -error_file uacerr.log



opensips-cli commands

--shows AOR list of registered users
opensips-cli -x mi ul_dump 

--moves data from cache to dB
opensips-cli -x mi ul_flush


--removes a contact
opensips-cli -x mi ul_rm location ramki@172.17.0.


-- https://www.opensips.org/Documentation/Tools
--after installing tshark




tshark -i eth0 -f 'udp port 5060' -w sip.pcap


tshark -r sip.pcap


Working Registration from opensips

https://www.opensips.org/About/PerformanceTests

https://github.com/jgilsonsi/sipp-stress-test

run the following in sipp container coltrey/sipp - it registers all users from ha1_users.csv and you can check them in opensips - location table
sipp -sf ha1_register.xml -inf ha1_users.csv -r 10 -m 1000000 -l 100 -nd -fd 1 -i 172.17.0.4 172.17.0.7:5060


finally a working scenario in sipp_client_type_scenario directory;
cd to sipp_client_type_scenario for more details
