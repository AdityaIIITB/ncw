//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package inet.examples.ncw;

import inet.node.inet.AdhocHostTCS;
import inet.applications.udpapp.UDPBasicApp;
import inet.applications.udpapp.UDPSink;
import inet.applications.voip.SimpleVoIPSender;
import inet.applications.voip.SimpleVoIPReceiver;
import inet.applications.tcpapp.TCPSessionApp;
import inet.applications.tcpapp.TCPSinkApp;


moduleinterface StandardHostExtInterface{

    
	gates:
    	inout pppg[];
    	inout ethg[];
}

module StandardHostExt extends AdhocHostTCS like StandardHostExtInterface
{
    parameters:
        int numHosts_perEntity;
     types:
        simple UDPSend extends UDPBasicApp
        {
            parameters:
                messageLength = default(452B);
                sendInterval = default(10ms);
        }

        simple UDPRecv extends UDPSink
        {
        }

        simple VoIPSend extends SimpleVoIPSender
        {
            parameters:
                talkPacketSize = default(97B);
                packetizationInterval = default(10ms);
        }

        simple VoIPRecv extends SimpleVoIPReceiver
        {
        }

        simple TCPSend extends TCPSessionApp
        {
        }

        simple TCPRecv extends TCPSinkApp
        {
        }
    
}

module StandardHostExtUln extends StandardHostExt like StandardHostExtInterface
{
    parameters:
        int n_udp_sent_by_l0_to_l1 = 6; // ULN --> ANC UDP (btns --> brigade)
        int n_udp_recv_by_l0_from_l1 = 6;
		numHosts_perEntity = 2;
        int n_udp_sent_by_l0_to_l2 = 4; // ULN --> ANB UDP (btns --> div)
        int n_udp_recv_by_l0_from_l2 = 4;
         types:
        simple UDPSend extends UDPBasicApp
        {
            parameters:
                messageLength = default(452B);
                sendInterval = default(10ms);
        }

        simple UDPRecv extends UDPSink
        {
        }

        simple VoIPSend extends SimpleVoIPSender
        {
            parameters:
                talkPacketSize = default(97B);
                packetizationInterval = default(10ms);
        }

        simple VoIPRecv extends SimpleVoIPReceiver
        {
        }

        simple TCPSend extends TCPSessionApp
        {
        }

        simple TCPRecv extends TCPSinkApp
        {
        }

    submodules:
	    // l0 <--> l1
        udp_sent_by_l0_to_l1[n_udp_sent_by_l0_to_l1]: UDPSend  {
            @display("p=69,23,row,50");
            localPort = 1000 + int(ancestorIndex(1)/numHosts_perEntity) * sizeof(udp_sent_by_l0_to_l1) + index;
            destPort = this.localPort;
            destAddresses = "Bde1.UserGroup1[0]";
//            destAddresses = replace(substringBefore((substringAfter(fullPath(),".")),"["),"uNHost","aNHost") 
//            + "["+ string(parentIndex() % numHosts_perEntity) + "]";
        }

        udp_recv_by_l0_from_l1[n_udp_recv_by_l0_from_l1]: UDPRecv  {
            @display("p=586,23,row,60");
            localPort = 1500 + int(parentIndex()/numHosts_perEntity)*n_udp_recv_by_l0_from_l1 + index;
        }

		// l0 <--> l2	
        udp_sent_by_l0_to_l2[n_udp_sent_by_l0_to_l2]: UDPSend {
            @display("p=255,23,row,60");
            localPort = 11000 + indexOfEntity * numUln_perBde * n_udp_sent_by_l0_to_l2 + int(ancestorIndex(1)/numHosts_perEntity) * n_udp_sent_by_l0_to_l2 + index;
            destPort = this.localPort;
            destAddresses = "Div.UserGroup1[0]";
        }


//        udp_recv_by_l0_from_l2[n_udp_recv_by_l0_from_l2]: UDPRecv if contains(fullPath(),"uNHost") && contains(fullPath(),"Inft_Bde_Rprt_1") { //only uNHost[0] is  
 //configured as receiver not all
        udp_recv_by_l0_from_l2[n_udp_recv_by_l0_from_l2]: UDPRecv {
            @display("p=419,23,row,60");
            localPort = 11500 + index;
        }
        
     connections:
        for i=0..sizeof(udp_sent_by_l0_to_l1)-1 {
            udp_sent_by_l0_to_l1[i].udpOut --> udp.appIn++;
            udp_sent_by_l0_to_l1[i].udpIn <-- udp.appOut++;
        }

        for i=0..sizeof(udp_recv_by_l0_from_l1)-1 {
            udp_recv_by_l0_from_l1[i].udpOut --> udp.appIn++;
            udp_recv_by_l0_from_l1[i].udpIn <-- udp.appOut++;
        }

        //l0 to l2
        for i=0..sizeof(udp_sent_by_l0_to_l2)-1 {
            udp_sent_by_l0_to_l2[i].udpOut --> udp.appIn++;
            udp_sent_by_l0_to_l2[i].udpIn <-- udp.appOut++;
        }

        for i=0..sizeof(udp_recv_by_l0_from_l2)-1 {
            udp_recv_by_l0_from_l2[i].udpOut --> udp.appIn++;
            udp_recv_by_l0_from_l2[i].udpIn <-- udp.appOut++;
        }
        
        
}

module StandardHostExtBde extends StandardHostExt like StandardHostExtInterface
{
    parameters:
        int n_udp_sent_by_l1_to_l0 = 6; // ANC* --> ULN UDP (brigade --> btns)
        int n_udp_recv_by_l1_from_l0 = 6;

        int n_udp_sent_by_l1_to_l2 = 50;
        int n_udp_recv_by_l1_from_l2 = 50;
	types:
        simple UDPSend extends UDPBasicApp
        {
            parameters:
                messageLength = default(452B);
                sendInterval = default(10ms);
        }

        simple UDPRecv extends UDPSink
        {
        }

        simple VoIPSend extends SimpleVoIPSender
        {
            parameters:
                talkPacketSize = default(97B);
                packetizationInterval = default(10ms);
        }

        simple VoIPRecv extends SimpleVoIPReceiver
        {
        }

        simple TCPSend extends TCPSessionApp
        {
        }

        simple TCPRecv extends TCPSinkApp
        {
        }
	submodules:
        // l0 <--> l1
        udp_sent_by_l1_to_l0[n_udp_sent_by_l1_to_l0]: UDPSend  {
            @display("p=132,23,row,80");
            localPort = 1500 + index; //% int(ceil(n_udp_sent_by_l1_to_l0/numULNs_perANX));
            destPort = this.localPort;
//            destAddresses = replace(substringBefore((substringAfter(fullPath(),".")),"["),"aNHost","uNHost") 
//            + "["+ string((int(index / int(ceil(n_udp_sent_by_l1_to_l0/numULNs_perANX))) * numHosts_perEntity)+parentIndex()) + "]";

            destAddresses = "Bn1.UserGroup1[0]";

        }

        udp_recv_by_l1_from_l0[n_udp_recv_by_l1_from_l0]: UDPRecv  {
            @display("p=558,23,row,60");
            localPort = 1000 + index;
        }

        // l1 <--> l2 (div main)
        udp_sent_by_l1_to_l2[n_udp_sent_by_l1_to_l2]: UDPSend  {

            @display("p=290,23,row,70");
            //localPort = 999 + index;
            localPort = 31000 + indexOfEntity * n_udp_sent_by_l1_to_l2 + index;
            destPort = this.localPort;
            destAddresses = "Div.UserGroup1[0]";
        }

        udp_recv_by_l1_from_l2[n_udp_recv_by_l1_from_l2]: UDPRecv  {

            @display("p=462,23,row,70");
            localPort = 31500 + index;
        }
       connections:

        // l1 to l0
        for i=0..sizeof(udp_sent_by_l1_to_l0)-1 {
            udp_sent_by_l1_to_l0[i].udpOut --> udp.appIn++;
            udp_sent_by_l1_to_l0[i].udpIn <-- udp.appOut++;
        }

        for i=0..sizeof(udp_recv_by_l1_from_l0)-1 {
            udp_recv_by_l1_from_l0[i].udpOut --> udp.appIn++;
            udp_recv_by_l1_from_l0[i].udpIn <-- udp.appOut++;
        }

        // l1 to l2
        for i=0..sizeof(udp_sent_by_l1_to_l2)-1 {
            udp_sent_by_l1_to_l2[i].udpOut --> udp.appIn++;
            udp_sent_by_l1_to_l2[i].udpIn <-- udp.appOut++;
        }

        for i=0..sizeof(udp_recv_by_l1_from_l2)-1 {
            udp_recv_by_l1_from_l2[i].udpOut --> udp.appIn++;
            udp_recv_by_l1_from_l2[i].udpIn <-- udp.appOut++;
        }
        
}

module StandardHostExtDiv extends StandardHostExt like StandardHostExtInterface
{
    parameters:

        int n_udp_sent_by_l2_to_l0 = 6; // ANB* --> ULN UDP (div --> btns)
        int n_udp_recv_by_l2_from_l0 = 6;

        int n_udp_sent_by_l2_to_l1 = 50;
        int n_udp_recv_by_l2_from_l1 = 50;
        
    types:
        simple UDPSend extends UDPBasicApp
        {
            parameters:
                messageLength = default(452B);
                sendInterval = default(10ms);
        }

        simple UDPRecv extends UDPSink
        {
        }

        simple VoIPSend extends SimpleVoIPSender
        {
            parameters:
                talkPacketSize = default(97B);
                packetizationInterval = default(10ms);
        }

        simple VoIPRecv extends SimpleVoIPReceiver
        {
        }

        simple TCPSend extends TCPSessionApp
        {
        }

        simple TCPRecv extends TCPSinkApp
        {
        }
     submodules:
        // l2 <--> l0
        udp_sent_by_l2_to_l0[n_udp_sent_by_l2_to_l0]: UDPSend  {
            @display("p=204,23,row,60");
            localPort = 11500 + index; // % int(ceil(n_udp_sent_by_l2_to_l0/numULNs_perANX));
            destPort = this.localPort;
            destAddresses = "Bn1.UserGroup1[0]";

        }

        udp_recv_by_l2_from_l0[n_udp_recv_by_l2_from_l0]: UDPRecv  {
            @display("p=431,23,row,60");
            localPort = 11000+index;
        }


        // l2 <--> l1
        udp_sent_by_l2_to_l1[n_udp_sent_by_l2_to_l1]: UDPSend {

            @display("p=110,29,row,70");
            localPort = 31500 + index;
            destPort = this.localPort;
            destAddresses = "Bde1.UserGroup1[0]";

        }
        udp_recv_by_l2_from_l1[n_udp_recv_by_l2_from_l1]: UDPRecv  {

            @display("p=501,23,row,70");
            localPort = 31000 + index;
        }
     connections:
        // l2 to l0
        for i=0..sizeof(udp_sent_by_l2_to_l0)-1 {
            udp_sent_by_l2_to_l0[i].udpOut --> udp.appIn++;
            udp_sent_by_l2_to_l0[i].udpIn <-- udp.appOut++;
        }

        for i=0..sizeof(udp_recv_by_l2_from_l0)-1 {
            udp_recv_by_l2_from_l0[i].udpOut --> udp.appIn++;
            udp_recv_by_l2_from_l0[i].udpIn <-- udp.appOut++;
        }

        // l2 to l1
        for i=0..sizeof(udp_sent_by_l2_to_l1)-1 {
            udp_sent_by_l2_to_l1[i].udpOut --> udp.appIn++;
            udp_sent_by_l2_to_l1[i].udpIn <-- udp.appOut++;
        }

        for i=0..sizeof(udp_recv_by_l2_from_l1)-1 {
            udp_recv_by_l2_from_l1[i].udpOut --> udp.appIn++;
            udp_recv_by_l2_from_l1[i].udpIn <-- udp.appOut++;
        }
        
}
