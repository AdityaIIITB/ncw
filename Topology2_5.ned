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

network Topology2_5
{
    parameters:
        @display("bgb=1000,1000;bgi=background/terrain,s");
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
            @display("p=437,540;i=networkNode");
        }
        NN2: CommunicationNodeB {
            @display("p=301,638;i=networkNode");
        }
        NN3: CommunicationNodeB {
            @display("p=537,702;i=networkNode");
        }
        Div: CommunicationNodeB {
            @display("p=635,563;i=division;b=50,,rect,#40D358,,0");
        }
        Bde1: CommunicationNodeC {
            @display("p=311,772;i=brigade;b=50,,rect,#EBD929,,0");
        }
        Bde2: CommunicationNodeC {
            @display("p=619,766;i=brigade;b=50,,rect,#EBD929,,0");
        }
        Bn1: NetworkSectorialNode {
            @display("p=138,723;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn2: NetworkSectorialNode {
            @display("p=457,836;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn3: NetworkSectorialNode {
            @display("p=202,514;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn4: NetworkSectorialNode {
            @display("p=760,757;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn5: NetworkSectorialNode {
            @display("p=845,609;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn6: NetworkSectorialNode {
            @display("p=845,731;i=battalion;b=50,,rect,#CF4A41,,0");
        }

        NN4: CommunicationNodeB {
            @display("p=437,428;i=networkNode");
        }
        NN5: CommunicationNodeB {
            @display("p=635,441;i=networkNode");
        }
        Corp: CommunicationNodeA {
            @display("p=550,325;i=networkNode");
        }
        Ascon: CommunicationNodeA {
            @display("p=550,225;i=networkNode");
        }

    connections:
        NN3.pppg++ <--> p2p104Mbps <--> NN1.pppg++;
        NN1.pppg++ <--> p2p104Mbps <--> NN2.pppg++;
        NN1.pppg++ <--> p2p16Mbps <--> Div.pppg++;
        Div.pppg++ <--> p2p16Mbps <--> NN3.pppg++;
        Bde1.pppg++ <--> p2p8Mbps <--> NN2.pppg++;
        Bde2.pppg++ <--> p2p8Mbps <--> NN3.pppg++;
        Bn2.pppg++ <--> p2p4Mbps <--> NN3.pppg++;
        Bn1.pppg++ <--> p2p4Mbps <--> NN2.pppg++;
        Bn3.pppg++ <--> p2p4Mbps <--> NN1.pppg++;
        Bn3.pppg++ <--> p2p4Mbps <--> NN2.pppg++;
        Bn4.pppg++ <--> p2p4Mbps <--> NN3.pppg++;
        Bn5.pppg++ <--> p2p4Mbps <--> NN3.pppg++;
        Bn5.pppg++ <--> p2p4Mbps <--> Bn6.pppg++;
        Bn1.pppg++ <--> p2p4Mbps <--> NN3.pppg++;
        Bn4.pppg++ <--> p2p4Mbps <--> NN1.pppg++;
        NN3.pppg++ <--> p2p4Mbps <--> Bn6.pppg++;
        Bde1.pppg++ <--> p2p8Mbps <--> NN3.pppg++;
        Bde2.pppg++ <--> p2p8Mbps <--> NN1.pppg++;
        NN1.pppg++ <--> p2p104Mbps <--> NN4.pppg++;
        NN1.pppg++ <--> p2p104Mbps <--> NN5.pppg++;
        NN4.pppg++ <--> p2p104Mbps <--> NN2.pppg++;
        NN5.pppg++ <--> p2p104Mbps <--> NN4.pppg++;
        Corp.pppg++ <--> p2p34Mbps <--> NN4.pppg++;
        Corp.pppg++ <--> p2p34Mbps <--> NN5.pppg++;
        Bn2.pppg++ <--> p2p4Mbps <--> NN2.pppg++;
        Corp.pppg++ <--> p2p34Mbps <--> NN4.pppg++;
        Corp.pppg++ <--> p2p104Mbps <--> Ascon.pppg++;
}

