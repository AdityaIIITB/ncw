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

module NetworkSectorialNode
{
    parameters:
        @display("i=/block/socket;bgb=200,200");
        int numberHosts;
    gates:
        inout pppg[];
    submodules:
        RadioShelter: Shelter {
            @display("p=100,50");
        }

        CommunicationShelter: Shelter {
            @display("p=100,150");
        }

        UserGroup1: UserLevelNode {
            parameters:
                @display("p=24,118");
        }

        UserGroup2: UserLevelNode {
            parameters:
                @display("p=178,118");
        }

    connections allowunconnected:
        CommunicationShelter.ethg++ <--> Optical1Gbps <--> RadioShelter.ethg++;

//        for j=0..(numberHosts/2)-1 {
//            CommunicationShelter.ethg++ <--> Optical1Gbps <--> UserGroup1[j].ethg++;
//            CommunicationShelter.ethg++ <--> Optical1Gbps <--> UserGroup2[j].ethg++; // TODO Wireless?
//        }
		CommunicationShelter.ethg++ <--> Optical1Gbps <--> UserGroup1.ethg++;
		CommunicationShelter.ethg++ <--> Optical1Gbps <--> UserGroup2.ethg++;
        for i=0..sizeof(pppg) - 1 {
            RadioShelter.pppg++ <--> pppg++;
        }
}
