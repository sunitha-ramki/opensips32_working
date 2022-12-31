got this whole section info from 
https://wiki.ezuce.com/display/sipXcom/Using+SIPp+to+run+Performance+Tests

in opensips container 
ngrep -W byline -td any . port 5060
press enter just before runnign sipp uac command



in sipp container
ha1_users.csv
ha1_register.xml


REGISTER service and sipp as users in location table by running sipp container cmd
sipp -sf ha1_register.xml -inf ha1_users.csv -r 10 -m 1000000 -l 100 -nd -fd 1 -i 172.17.0.4 172.17.0.7:5060

in sipp container - uas cmd
sipp -sn uas -d 0 -p 5074 -i 172.17.0.4 -rsa 172.17.0.7:5060 -trace_msg -message_file uasmsg.log

uac cmd

sipp -sn uac -m 1 -rsa 172.17.0.7:5060 -i 172.17.0.4 -p 5075 172.17.0.4:5074 -trace_msg -message_file uasmsg.log

#opensips container 
ngrep output

root@2b1e3a26bcf0:/# ngrep -W byline -td any . port 5060
interface: any
filter: ( port 5060 ) and (ip || ip6)
match: .
#
U 2022/12/31 17:16:02.660789 172.17.0.4:5075 -> 172.17.0.7:5060 #1
INVITE sip:service@172.17.0.4:5074 SIP/2.0.
Via: SIP/2.0/UDP 172.17.0.4:5075;branch=z9hG4bK-1445-1-0.
From: sipp <sip:sipp@172.17.0.4:5075>;tag=1445SIPpTag001.
To: service <sip:service@172.17.0.4:5074>.
Call-ID: 1-1445@172.17.0.4.
CSeq: 1 INVITE.
Contact: sip:sipp@172.17.0.4:5075.
Max-Forwards: 70.
Subject: Performance Test.
Content-Type: application/sdp.
Content-Length:   131.
.
v=0.
o=user1 53655765 2353687637 IN IP4 172.17.0.4.
s=-.
c=IN IP4 172.17.0.4.
t=0 0.
m=audio 6008 RTP/AVP 0.
a=rtpmap:0 PCMU/8000.

#
U 2022/12/31 17:16:02.661380 172.17.0.7:5060 -> 172.17.0.4:5075 #2
SIP/2.0 100 Giving it a try.
Via: SIP/2.0/UDP 172.17.0.4:5075;branch=z9hG4bK-1445-1-0.
To: service <sip:service@172.17.0.4:5074>.
From: sipp <sip:sipp@172.17.0.4:5075>;tag=1445SIPpTag001.
Call-ID: 1-1445@172.17.0.4.
CSeq: 1 INVITE.
Server: OpenSIPS (3.2.10 (x86_64/linux)).
Content-Length: 0.
.

#
U 2022/12/31 17:16:02.662040 172.17.0.7:5060 -> 172.17.0.4:5074 #3
INVITE sip:service@172.17.0.4:5074 SIP/2.0.
Record-Route: <sip:172.17.0.7;lr>.
Via: SIP/2.0/UDP 172.17.0.7:5060;branch=z9hG4bK1f9f.91be7586.0.
Via: SIP/2.0/UDP 172.17.0.4:5075;branch=z9hG4bK-1445-1-0.
From: sipp <sip:sipp@172.17.0.4:5075>;tag=1445SIPpTag001.
To: service <sip:service@172.17.0.4:5074>.
Call-ID: 1-1445@172.17.0.4.
CSeq: 1 INVITE.
Contact: sip:sipp@172.17.0.4:5075.
Max-Forwards: 69.
Subject: Performance Test.
Content-Type: application/sdp.
Content-Length:   131.
.
v=0.
o=user1 53655765 2353687637 IN IP4 172.17.0.4.
s=-.
c=IN IP4 172.17.0.4.
t=0 0.
m=audio 6008 RTP/AVP 0.
a=rtpmap:0 PCMU/8000.

#
U 2022/12/31 17:16:03.111425 172.17.0.7:5060 -> 172.17.0.4:5074 #4
INVITE sip:service@172.17.0.4:5074 SIP/2.0.
Record-Route: <sip:172.17.0.7;lr>.
Via: SIP/2.0/UDP 172.17.0.7:5060;branch=z9hG4bK1f9f.91be7586.0.
Via: SIP/2.0/UDP 172.17.0.4:5075;branch=z9hG4bK-1445-1-0.
From: sipp <sip:sipp@172.17.0.4:5075>;tag=1445SIPpTag001.
To: service <sip:service@172.17.0.4:5074>.
Call-ID: 1-1445@172.17.0.4.
CSeq: 1 INVITE.
Contact: sip:sipp@172.17.0.4:5075.
Max-Forwards: 69.
Subject: Performance Test.
Content-Type: application/sdp.
Content-Length:   131.
.
v=0.
o=user1 53655765 2353687637 IN IP4 172.17.0.4.
s=-.
c=IN IP4 172.17.0.4.
t=0 0.
m=audio 6008 RTP/AVP 0.
a=rtpmap:0 PCMU/8000.

#
U 2022/12/31 17:16:04.116492 172.17.0.7:5060 -> 172.17.0.4:5074 #5
INVITE sip:service@172.17.0.4:5074 SIP/2.0.
Record-Route: <sip:172.17.0.7;lr>.
Via: SIP/2.0/UDP 172.17.0.7:5060;branch=z9hG4bK1f9f.91be7586.0.
Via: SIP/2.0/UDP 172.17.0.4:5075;branch=z9hG4bK-1445-1-0.
From: sipp <sip:sipp@172.17.0.4:5075>;tag=1445SIPpTag001.
To: service <sip:service@172.17.0.4:5074>.
Call-ID: 1-1445@172.17.0.4.
CSeq: 1 INVITE.
Contact: sip:sipp@172.17.0.4:5075.
Max-Forwards: 69.
Subject: Performance Test.
Content-Type: application/sdp.
Content-Length:   131.
.
v=0.
o=user1 53655765 2353687637 IN IP4 172.17.0.4.
s=-.
c=IN IP4 172.17.0.4.
t=0 0.
m=audio 6008 RTP/AVP 0.
a=rtpmap:0 PCMU/8000.

#
U 2022/12/31 17:16:06.126727 172.17.0.7:5060 -> 172.17.0.4:5074 #6
INVITE sip:service@172.17.0.4:5074 SIP/2.0.
Record-Route: <sip:172.17.0.7;lr>.
Via: SIP/2.0/UDP 172.17.0.7:5060;branch=z9hG4bK1f9f.91be7586.0.
Via: SIP/2.0/UDP 172.17.0.4:5075;branch=z9hG4bK-1445-1-0.
From: sipp <sip:sipp@172.17.0.4:5075>;tag=1445SIPpTag001.
To: service <sip:service@172.17.0.4:5074>.
Call-ID: 1-1445@172.17.0.4.
CSeq: 1 INVITE.
Contact: sip:sipp@172.17.0.4:5075.
Max-Forwards: 69.
Subject: Performance Test.
Content-Type: application/sdp.
Content-Length:   131.
.
v=0.
o=user1 53655765 2353687637 IN IP4 172.17.0.4.
s=-.
c=IN IP4 172.17.0.4.
t=0 0.
m=audio 6008 RTP/AVP 0.
a=rtpmap:0 PCMU/8000.

#
U 2022/12/31 17:16:07.574425 172.17.0.7:5060 -> 172.17.0.4:5075 #7
SIP/2.0 408 Request Timeout.
Via: SIP/2.0/UDP 172.17.0.4:5075;branch=z9hG4bK-1445-1-0.
To: service <sip:service@172.17.0.4:5074>;tag=2461-13a255bca3d312e7df0340d131e413ae.
From: sipp <sip:sipp@172.17.0.4:5075>;tag=1445SIPpTag001.
Call-ID: 1-1445@172.17.0.4.
CSeq: 1 INVITE.
Server: OpenSIPS (3.2.10 (x86_64/linux)).
Content-Length: 0.
.

#
U 2022/12/31 17:16:07.576286 172.17.0.4:5075 -> 172.17.0.7:5060 #8
ACK sip:service@172.17.0.4:5074 SIP/2.0.
Via: SIP/2.0/UDP 172.17.0.4:5075;branch=z9hG4bK-1445-1-0.
From: sipp <sip:sipp@172.17.0.4:5075>;tag=1445SIPpTag001.
To: service <sip:service@172.17.0.4:5074>;tag=2461-13a255bca3d312e7df0340d131e413ae.
Call-ID: 1-1445@172.17.0.4.
CSeq: 1 ACK.
Contact: <sip:sipp@172.17.0.4:5075;transport=UDP>.
Max-Forwards: 70.
Subject: Performance Test.
Content-Length: 0.
.






