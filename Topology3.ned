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
import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.physicallayer.idealradio.IdealRadioMedium;

network Topology3
{
    parameters:
        @display("bgb=1636,999;bgi=background/terrain,s");
    submodules:
        // TODO
        configurator: IPv4NetworkConfigurator {
            parameters:
                @display("p=74,24");
        }
//        radioMedium: IdealRadioMedium {
//            parameters:
//                @display("p=59,86");
//        }

        NN1: CommunicationNodeB {
            @display("p=871,564;i=networkNode;is=s");
        }
        NN2: CommunicationNodeB {
            @display("p=735,662;i=networkNode");
        }
        NN3: CommunicationNodeB {
            @display("p=971,726;i=networkNode");
        }
        Div1: CommunicationNodeB {
            @display("p=984,616;i=division;b=50,,rect,#40D358,,0");
        }
        Bde1: CommunicationNodeC {
            @display("p=852,698;i=brigade;b=50,,rect,#EBD929,,0");
        }
        Bde2: CommunicationNodeC {
            @display("p=1095,861;i=brigade;b=50,,rect,#EBD929,,0");
        }
        Bn1: NetworkSectorialNode {
            @display("p=572,747;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn2: NetworkSectorialNode {
            @display("p=832,877;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn3: NetworkSectorialNode {
            @display("p=677,847;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn4: NetworkSectorialNode {
            @display("p=998,894;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn5: NetworkSectorialNode {
            @display("p=1281,726;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn6: NetworkSectorialNode {
            @display("p=1161,649;i=battalion;b=50,,rect,#CF4A41,,0");
        }

        NN4: CommunicationNodeB {
            @display("p=871,452;i=networkNode");
        }
        NN5: CommunicationNodeB {
            @display("p=1069,465;i=networkNode");
        }
        Corp: CommunicationNodeA {
            @display("p=984,349;i=networkNode");
        }
        Ascon: CommunicationNodeA {
            @display("p=813,285;i=networkNode");
        }

        NN6: CommunicationNodeB {
            @display("p=803,790;i=networkNode");
        }
        NN7: CommunicationNodeB {
            @display("p=1168,801;i=networkNode");
        }
        NN8: CommunicationNodeB {
            @display("p=1086,584;i=networkNode");
        }
        NN9: CommunicationNodeB {
            @display("p=1217,577;i=networkNode");
        }
        NN10: CommunicationNodeB {
            @display("p=1274,502;i=networkNode");
        }
        Bde3: CommunicationNodeC {
            @display("p=1405,498;i=brigade;b=50,,rect,#EBD929,,0");
        }
        Bn7: NetworkSectorialNode {
            @display("p=1369,610;i=battalion;b=50,,rect,#CF4A41,,0");
        }

        Bn8: NetworkSectorialNode {
            @display("p=1507,548;i=battalion;b=50,,rect,#CF4A41,,0");
        }

        Bn9: NetworkSectorialNode {
            @display("p=1507,419;i=battalion;b=50,,rect,#CF4A41,,0");
        }

    connections:
        NN3.pppg++ <--> p2p104Mbps <--> NN1.pppg++;
        NN1.pppg++ <--> p2p104Mbps <--> NN2.pppg++;
        NN1.pppg++ <--> p2p16Mbps <--> Div1.pppg++;
        Div1.pppg++ <--> p2p16Mbps <--> NN3.pppg++;
        Bde1.pppg++ <--> p2p8Mbps <--> NN2.pppg++;
        Bde2.pppg++ <--> p2p8Mbps <--> NN6.pppg++;
        Bn2.pppg++ <--> p2p4Mbps <--> NN3.pppg++;
        Bn1.pppg++ <--> p2p4Mbps <--> NN2.pppg++;
        Bn3.pppg++ <--> p2p4Mbps <--> NN6.pppg++;
        Bn3.pppg++ <--> p2p4Mbps <--> NN2.pppg++;
        Bn4.pppg++ <--> p2p4Mbps <--> NN3.pppg++;
        Bn5.pppg++ <--> p2p4Mbps <--> NN3.pppg++;

        Bn7.pppg++ <--> p2p4Mbps <--> NN9.pppg++;
        Bn8.pppg++ <--> p2p4Mbps <--> NN9.pppg++;
        Bn9.pppg++ <--> p2p4Mbps <--> NN9.pppg++;
        Bn7.pppg++ <--> p2p4Mbps <--> NN10.pppg++;
        Bn8.pppg++ <--> p2p4Mbps <--> NN10.pppg++;
        Bn9.pppg++ <--> p2p4Mbps <--> NN10.pppg++;

        Bn5.pppg++ <--> p2p4Mbps <--> NN7.pppg++;
        Bn1.pppg++ <--> p2p4Mbps <--> NN6.pppg++;
        Bn4.pppg++ <--> p2p4Mbps <--> NN6.pppg++;
        NN7.pppg++ <--> p2p4Mbps <--> Bn6.pppg++;
        Bde1.pppg++ <--> p2p8Mbps <--> NN3.pppg++;
        Bde2.pppg++ <--> p2p8Mbps <--> NN7.pppg++;
        NN1.pppg++ <--> p2p104Mbps <--> NN4.pppg++;
        NN1.pppg++ <--> p2p104Mbps <--> NN5.pppg++;
        NN5.pppg++ <--> p2p104Mbps <--> NN4.pppg++;
        Corp.pppg++ <--> p2p34Mbps <--> NN4.pppg++;
        Corp.pppg++ <--> p2p34Mbps <--> NN5.pppg++;
        Bn2.pppg++ <--> p2p4Mbps <--> NN6.pppg++;
        Corp.pppg++ <--> p2p34Mbps <--> NN4.pppg++;
        NN4.pppg++ <--> p2p104Mbps <--> Ascon.pppg++;
        NN6.pppg++ <--> p2p104Mbps <--> NN2.pppg++;
        NN3.pppg++ <--> p2p104Mbps <--> NN6.pppg++;
        NN9.pppg++ <--> p2p4Mbps <--> Bn6.pppg++;
        NN8.pppg++ <--> p2p104Mbps <--> NN5.pppg++;
        NN10.pppg++ <--> p2p104Mbps <--> NN5.pppg++;
        NN10.pppg++ <--> p2p104Mbps <--> NN8.pppg++;


        NN9.pppg++ <--> p2p104Mbps <--> NN8.pppg++;
        NN7.pppg++ <--> p2p104Mbps <--> NN8.pppg++;
        NN7.pppg++ <--> p2p104Mbps <--> NN3.pppg++;
        NN7.pppg++ <--> p2p104Mbps <--> NN6.pppg++;

        NN3.pppg++ <--> p2p104Mbps <--> NN8.pppg++;

        NN7.pppg++ <--> p2p104Mbps <--> NN9.pppg++;

        NN10.pppg++ <--> p2p104Mbps <--> NN9.pppg++;
        Bde3.pppg++ <--> p2p8Mbps <--> NN10.pppg++;
        Bde3.pppg++ <--> p2p8Mbps <--> NN9.pppg++;
}
