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

// Used in Network Nodes
channel Optical10Gbps extends ned.DatarateChannel{
 	@display("ls=orange");
	delay = 1.01ms;
	datarate = 10Gbps;
	ber = 0.000000000001;//11
}

channel Optical1Gbps extends ned.DatarateChannel{
	@display("ls=maroon");
	delay = 1.01ms;
	datarate = 1Gbps;
	ber = 0.000000001;//9
}

channel p2p104Mbps extends ned.DatarateChannel{
 	@display("ls=darkgreen");
	delay = 1.1ms;
	datarate = 102Mbps;
	ber = 0.000001; //6
}

channel p2p34Mbps extends ned.DatarateChannel{
 	@display("ls=blue");
	delay = 1.1ms;
	datarate = 34Mbps;
	ber = 0.000001;
}

channel p2p16Mbps extends ned.DatarateChannel{
 	@display("ls=red");
	delay = 1.1ms;
	datarate = 16Mbps;
	ber = 0.000001;
}

channel p2p8Mbps extends ned.DatarateChannel{
 	@display("ls=yellow");
	delay = 1.1ms;
	datarate = 8Mbps;
	ber = 0.000001;
}

channel p2p4Mbps extends ned.DatarateChannel{
 	@display("ls=orange");
	delay = 1.1ms;
	datarate = 4Mbps;
	ber = 0.000001;
}