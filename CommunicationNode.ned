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

module CommunicationNode{
    parameters:
        @display("i=/abstract/server;bgb=300,300");
        int numberHosts;
    gates:
        inout pppg[];  
	submodules:
	    RadioShelter : Shelter{
	        parameters:
	            @display("p=50,50");
	    }
	    
	    CommunicationShelter : Shelter{
	        parameters:
	            @display("p=50,250");
	            
	    }
	    
	    FWSShelter : Shelter{ // Field Wireless Services
	        parameters:
	            @display("p=250,250");
	    }
	    
	    CNRShelter : Shelter{ // Combat Net Radio
	        parameters:
	            @display("p=250,50");
	    }
	    
	    UserGroup1 : UserLevelNode{
	        parameters:
	            @display("p=100,150");
	    }
	    
	    UserGroup2[1] : UserLevelNode{
	        parameters:
	            @display("p=200,150");
	    }
	   connections allowunconnected:
	        RadioShelter.ethg++ <--> Optical10Gbps <--> CommunicationShelter.ethg++;
    	    FWSShelter.ethg++ <--> Optical10Gbps <--> CommunicationShelter.ethg++;
    	    RadioShelter.ethg++ <--> Optical10Gbps <--> CNRShelter.ethg++;
    	    FWSShelter.ethg++ <--> Optical10Gbps <--> CNRShelter.ethg++;
    	    
//    	     for j=0..(numberHosts/2)-1 
//        {
//    	    CommunicationShelter.ethg++ <--> Optical1Gbps <--> UserGroup1[j].ethg++;
//	    	FWSShelter.ethg++ <--> Optical1Gbps <--> UserGroup2[j].ethg++; // TODO Wireless?
//        }	

	    	CommunicationShelter.ethg++ <--> Optical1Gbps <--> UserGroup1.ethg++;
			for i=0..sizeof(UserGroup2) - 1 {
				FWSShelter.ethg++ <--> Optical1Gbps <--> UserGroup2[i].ethg++;
			}
			for i=0..sizeof(pppg) - 1 {
            	RadioShelter.pppg++ <--> pppg++;
        }
}