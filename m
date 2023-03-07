From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 7 Mar 2023 21:35:42 +0100
Subject: [PATCH net-next v2 4/6] net: mdio: scan bus based on bus
 capabilities for C22 and C45
In-Reply-To: <0e10aa8492eadb587949d8744b56fccaabbd183b.camel@gmail.com>
References: <20230116-net-next-remove-probe-capabilities-v2-0-15513b05e1f4@walle.cc>
 <20230116-net-next-remove-probe-capabilities-v2-4-15513b05e1f4@walle.cc>
 <449bde236c08d5ab5e54abd73b645d8b29955894.camel@gmail.com>
 <100c439a-2a4d-4cb2-96f2-5bf273e2121a@lunn.ch>
 <712bc92ca6d576f33f63f1e9c2edf0030b10d3ae.camel@gmail.com>
 <db6b8a09-b680-4baa-8963-d355ad29eb09@lunn.ch>
 <0e10aa8492eadb587949d8744b56fccaabbd183b.camel@gmail.com>
Message-ID: <72530e86-9ba9-4a01-9cd2-68835ecae7a0@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Summary: Still 4 calls to mdio_bus_scan_c22, but also *2* calls to mdio_bus_scan_c45, approx. 190*100 reads by the switch driver

Those calls to mdio_bus_scan_c45 are caused by 743a19e38d02 net: dsa:
mv88e6xxx: Separate C22 and C45 transactions.

Some families of the mv88e6xxx do support C45 bus transactions. That
includes the 6171 you have. Before, we never scanned the C45 bus, but
now we do.

But something does not add up. Doing an additional c45 scan should
only double the number of reads by the switch driver.

The only part of a c45 scan which is not linear is
mv88e6xxx_g2_smi_phy_wait() which is implemented by
mv88e6xxx_wait_mask(). That loops reading a register waiting for a bit
to change. Maybe print out the value of i, and see if it is looping
more times for C45 than C22?

     Andrew
