From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 9 Mar 2023 17:36:25 +0100
Subject: [PATCH net-next v2 4/6] net: mdio: scan bus based on bus
 capabilities for C22 and C45
In-Reply-To: <09d65e1ee0679e1e74b4f3a5a4c55bd48332f043.camel@gmail.com>
References: <20230116-net-next-remove-probe-capabilities-v2-0-15513b05e1f4@walle.cc>
 <20230116-net-next-remove-probe-capabilities-v2-4-15513b05e1f4@walle.cc>
 <449bde236c08d5ab5e54abd73b645d8b29955894.camel@gmail.com>
 <100c439a-2a4d-4cb2-96f2-5bf273e2121a@lunn.ch>
 <712bc92ca6d576f33f63f1e9c2edf0030b10d3ae.camel@gmail.com>
 <db6b8a09-b680-4baa-8963-d355ad29eb09@lunn.ch>
 <0e10aa8492eadb587949d8744b56fccaabbd183b.camel@gmail.com>
 <72530e86-9ba9-4a01-9cd2-68835ecae7a0@lunn.ch>
 <09d65e1ee0679e1e74b4f3a5a4c55bd48332f043.camel@gmail.com>
Message-ID: <70f5bca0-322c-4bae-b880-742e56365abe@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 08, 2023 at 07:34:40PM +0100, Klaus Kudielka wrote:
> On Tue, 2023-03-07 at 21:35 +0100, Andrew Lunn wrote:
> > > Summary: Still 4 calls to mdio_bus_scan_c22, but also *2* calls to mdio_bus_scan_c45, approx. 190*100 reads by the switch driver

I was wrong about something i said earlier. A C22 scan reads two
registers for each of the 32 possible locations of a C22 PHY on the
bus. A C45 scan is however much more expensive. It will read 30 time
two registers for each of the 32 possible locations of a C45 PHY on
the bus.

One things that could help is moving some code around a bit. Currently
mv88e6xxx_mdios_register() is called at the end of
mv88e6xxx_probe(). Try moving it to the beginning of
mv88e6xxx_setup(). The call to mv88e6xxx_mdios_unregister() then need
to move into mv88e6xxx_teardown().

	Andrew

