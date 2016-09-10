portTrack = 1025

topology = "Topology3"

def addCallTo(dst,src,typ):
    global portTrack
    if(typ == 'voip'):
        
        print src,udpAppCount[src],"calling",dst,udpAppCount[dst],"over",portTrack
        line1 = ''+topology+'.'+src+'.UserGroup1.udpApp['+str(udpAppCount[src])+'].typename = "SimpleVoIPSender"\n'
        inifile.write(line1)
        line2 = ''+topology+'.'+src+'.UserGroup1.udpApp['+str(udpAppCount[src])+'].destPort = '+str(portTrack)+'\n'
        line3 = ''+topology+'.'+src+'.UserGroup1.udpApp['+str(udpAppCount[src])+'].destAddress = "'+dst+'.UserGroup1"\n'
        line4 = ''+topology+'.'+dst+'.UserGroup1.udpApp['+str(udpAppCount[dst])+'].typename = "SimpleVoIPReceiver"\n'
        line5 = ''+topology+'.'+dst+'.UserGroup1.udpApp['+str(udpAppCount[dst])+'].localPort = '+str(portTrack)+'\n\n\n\n'
        inifile.write(line2)
        inifile.write(line3)
        inifile.write(line4)
        inifile.write(line5)
        
        portTrack += 1
        udpAppCount[src] += 1
        udpAppCount[dst] += 1
    elif(typ == 'tcp'):
        
        print src,tcpAppCount[src],"calling",dst,tcpAppCount[dst],"over",portTrack
        line1 = ''+topology+'.'+src+'.UserGroup1.tcpApp['+str(tcpAppCount[src])+'].typename = "TCPSessionApp"\n'
        inifile.write(line1)
        line2 = ''+topology+'.'+src+'.UserGroup1.tcpApp['+str(tcpAppCount[src])+'].active = true\n'
        line3 = ''+topology+'.'+src+'.UserGroup1.tcpApp['+str(tcpAppCount[src])+'].tOpen = 0\n'
        line4 = ''+topology+'.'+src+'.UserGroup1.tcpApp['+str(tcpAppCount[src])+'].tSend = 0\n'
        line5 = ''+topology+'.'+src+'.UserGroup1.tcpApp['+str(tcpAppCount[src])+'].sendBytes = 1MiB\n'
        line6 = ''+topology+'.'+src+'.UserGroup1.tcpApp['+str(tcpAppCount[src])+'].tClose = -1s\n'
        line7 = ''+topology+'.'+dst+'.UserGroup1.tcpApp['+str(tcpAppCount[dst])+'].typename = "TCPSinkApp"\n'
        line8 = ''+topology+'.'+src+'.UserGroup1.tcpApp['+str(tcpAppCount[src])+'].connectAddress = "'+dst+'.UserGroup1"\n'
        line9 = ''+topology+'.'+src+'.UserGroup1.tcpApp['+str(tcpAppCount[src])+'].connectPort = '+str(portTrack)+'\n'
        line10 = ''+topology+'.'+dst+'.UserGroup1.tcpApp['+str(tcpAppCount[src])+'].localPort = 3100\n'
        line10 = ''+topology+'.'+dst+'.UserGroup1.tcpApp['+str(tcpAppCount[dst])+'].localPort = '+str(portTrack)+'\n\n\n\n'
        inifile.write(line2)
        inifile.write(line3)
        inifile.write(line4)
        inifile.write(line5)
        inifile.write(line6)
        inifile.write(line7)
        inifile.write(line8)
        inifile.write(line9)
        inifile.write(line10)
        
        portTrack += 1
        tcpAppCount[src] += 1
        tcpAppCount[dst] += 1

def getParent(node):
	return parent[node]

def getGrandparent(node):
	return parent[parent[node]]

def addCallsAtLevel(srcLevel, dstLevel, count, typ):
    for i in range(len(nodesOfLevel[srcLevel])): # for every node in that level
        src = nodesOfLevel[srcLevel][i]
        for j in range(count): # for count number of times in each node of that level
            #add call from each node so many times
            determinant = srcLevel - dstLevel
            if determinant == 1: # parent
                addCallTo(getParent(src),src,typ)
            elif determinant == 2: # grand-parent
                addCallTo(getGrandparent(src),src,typ)
            elif determinant == 0: # lateral
                lat = nodesOfLevel[srcLevel][(i+1)%len(nodesOfLevel[srcLevel])]
                addCallTo(lat, src, typ)



parent = {"Corp": "Ascon",
		      "Div1": "Corp",
				  "Bde1": "Div1", 
					  "Bn1": "Bde1", "Bn2": "Bde1", "Bn3": "Bde1",
				  "Bde2": "Div1",
					  "Bn4": "Bde2", "Bn5": "Bde2", "Bn6": "Bde2",
				  "Bde3": "Div1", 
					  "Bn7": "Bde3", "Bn8": "Bde3", "Bn9": "Bde3",
          }

appCount = {"Ascon": 0,
		      "Corp": 0,
				  "Div1": 0,
					  "Bde1": 0,
						  "Bn1": 0, "Bn2": 0, "Bn3": 0,
					  "Bde2": 0,
						  "Bn4": 0, "Bn5": 0, "Bn6": 0,
					  "Bde3": 0,
						  "Bn7": 0, "Bn8": 0, "Bn9": 0,
          }

nodesOfLevel = [["Ascon"],
                ["Corp"],
                ["Div1"],
                ["Bde1", "Bde2", "Bde3"],
                ["Bn1","Bn2","Bn3", "Bn4","Bn5","Bn6", "Bn7","Bn8","Bn9"]
                ]

inifile = open("test.ini",'w')
inifile.write('[General]\nnetwork = '+topology+'\n\n**.scalar-recording = false\n**.vector-recording = false\n**.manetrouting.interfaces="prefix(eth) prefix(ppp)"\n**.numRadios=0\n\n\n# Limit on the number of readings to take\n'+topology+'.**.limit = 1000\n**.routingProtocol="OLSR"\n**.configurator.config = xmldoc("config.xml")\n\n# VOIP Parameters\n'+topology+'.**.talkPacketSize = (138B + 8B) + 10B # Header (138 + 8) + Payload (10)\n'+topology+'.**.packetizationInterval = 10ms # 100 Packets per second\n'+topology+'.**.talkspurtDuration = 30s\n'+topology+'.**.playoutDelay = 30ms\n\n\n')



# VOICE CALLS
voiceCalls = [
    [0,0,0,0,0],#ASCONN
    [71,0,0,0,0],#CORPS*1*71=71
    [10,48,0,0,0],#DIV*1*58=58
    [0,4,18,4,0],#BDE*3*26=78
    [0,0,2,9,2],#BLN*9*13
]
udpAppCount = dict(appCount)
for i in range(1,len(voiceCalls)):
    for j in range(len(voiceCalls[i])):
        addCallsAtLevel(i,j,voiceCalls[i][j],"voip")

print "\n\n\n\n\n\n\n\nSTART"
# TCP DATA
tcpData = [
    [0,0,0,0,0],#ASCONN
    [34,0,0,0,0],#CORPS*1*34=34
    [0,23,0,0,0],#DIV*1*23=23
    [0,2,9,1,0],#BDE*3*12=36
    [0,0,1,4,1],#BLN*9*
]
tcpAppCount = dict(appCount)
for i in range(1,len(tcpData)):
    for j in range(len(tcpData[i])):
        addCallsAtLevel(i,j,tcpData[i][j],"tcp")


# add udpAppCounts in the footer
for i in udpAppCount:
    inifile.write(''+topology+'.'+i+'.UserGroup1.numUdpApps='+str(udpAppCount[i])+'\n')

inifile.write('\n\n')
for i in tcpAppCount:
    inifile.write(''+topology+'.'+i+'.UserGroup1.numTcpApps='+str(tcpAppCount[i])+'\n')
inifile.write('\n\n')

inifile.write('**.ppp[*].egressTCType = "TrafficConditioner2"\n**.ppp[*].queueType = "DiffservQueue"\n**.ppp[*].queue.efMeter.cir = "70%" # reserved bandwith for EF packets\n**.ppp[*].queue.efMeter.cbs = 5000B\n**.efMeter.cir = "70%"\n**.efMeter.cbs = 50KiB\n**.defaultMeter.cir = "30%"\n**.defaultMeter.cbs = 2KiB\n**.defaultMeter.ebs = 4KiB\n')

inifile.write('**.numberHosts = 0')

inifile.close()
