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

network Topology2
{
    parameters:
        @display("bgb=1000,1000;bgi=/background/terrain,s");
    submodules:
        // TODO
        configurator: IPv4NetworkConfigurator {
            parameters:
                @display("p=74,24");
        }
        radioMedium: IdealRadioMedium {
            parameters:
                @display("p=59,86");
        }

        NN1: CommunicationNodeB {
            @display("p=393,417;i=networkNode");
        }
        NN2: CommunicationNodeB {
            @display("p=248,333;i=networkNode");
        }
        NN3: CommunicationNodeB {
            @display("p=576,417;i=networkNode");
        }
        Div: CommunicationNodeB {
            @display("p=607,287;i=division;b=50,,rect,#40D358,,0");
        }
        Bde1: CommunicationNodeC {
            @display("p=283,496;i=brigade;b=50,,rect,#EBD929,,0");
        }
        Bde2: CommunicationNodeC {
            @display("p=571,490;i=brigade;b=50,,rect,#EBD929,,0");
        }
        Bn1: NetworkSectorialNode {
            @display("p=110,447;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn2: NetworkSectorialNode {
            @display("p=480,527;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn3: NetworkSectorialNode {
            @display("p=360,264;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn4: NetworkSectorialNode {
            @display("p=688,518;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn5: NetworkSectorialNode {
            @display("p=817,333;i=battalion;b=50,,rect,#CF4A41,,0");
        }
        Bn6: NetworkSectorialNode {
            @display("p=817,455;i=battalion;b=50,,rect,#CF4A41,,0");
        }

        NN4: CommunicationNodeB {
            @display("p=409,152;i=networkNode");
        }
        NN5: CommunicationNodeB {
            @display("p=607,165;i=networkNode");
        }
        Corp: CommunicationNodeA {
            @display("p=522,49;i=networkNode");
        }

    connections:
        NN3.pppg++ <--> p2p104Mbps <--> NN1.pppg++;
        NN1.pppg++ <--> p2p104Mbps <--> NN2.pppg++;
        NN1.pppg++ <--> p2p34Mbps <--> Div.pppg++;
        Div.pppg++ <--> p2p34Mbps <--> NN3.pppg++;
        Bde1.pppg++ <--> p2p8Mbps <--> NN2.pppg++;
        Bde2.pppg++ <--> p2p8Mbps <--> NN3.pppg++;
        Bn2.pppg++ <--> p2p4Mbps <--> Bde2.pppg++;
        Bn2.pppg++ <--> p2p4Mbps <--> NN3.pppg++;
        Bn1.pppg++ <--> p2p4Mbps <--> Bde1.pppg++;
        Bn1.pppg++ <--> p2p4Mbps <--> NN2.pppg++;
        Bn3.pppg++ <--> p2p4Mbps <--> NN1.pppg++;
        Bn3.pppg++ <--> p2p4Mbps <--> NN2.pppg++;
        Bn4.pppg++ <--> p2p4Mbps <--> NN3.pppg++;
        Bn5.pppg++ <--> p2p4Mbps <--> NN3.pppg++;
        Bn5.pppg++ <--> p2p4Mbps <--> Bn6.pppg++;
        NN4.pppg++ <--> p2p104Mbps <--> NN2.pppg++;
        NN1.pppg++ <--> p2p104Mbps <--> NN4.pppg++;
}
