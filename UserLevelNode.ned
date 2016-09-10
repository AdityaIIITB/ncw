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

import inet.node.inet.AdhocHost;

module UserLevelNode extends AdhocHost {
	// TODO: What do we model here?
	// Traffic generation source is always from here. So we can use that as a parameter in the design
	parameters:
		@display("i=/abstract/people");
		
		int numUsers = default (0);
//		numUdpApps = numUsers;
}