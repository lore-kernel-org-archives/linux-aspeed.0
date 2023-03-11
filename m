From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 11 Mar 2023 16:39:36 +0100
Subject: [PATCH net-next v2 4/6] net: mdio: scan bus based on bus
 capabilities for C22 and C45
In-Reply-To: <bff0e542b8c04980e9e3af1d3e6bf739c87eb514.camel@gmail.com>
References: <100c439a-2a4d-4cb2-96f2-5bf273e2121a@lunn.ch>
 <712bc92ca6d576f33f63f1e9c2edf0030b10d3ae.camel@gmail.com>
 <db6b8a09-b680-4baa-8963-d355ad29eb09@lunn.ch>
 <0e10aa8492eadb587949d8744b56fccaabbd183b.camel@gmail.com>
 <72530e86-9ba9-4a01-9cd2-68835ecae7a0@lunn.ch>
 <09d65e1ee0679e1e74b4f3a5a4c55bd48332f043.camel@gmail.com>
 <70f5bca0-322c-4bae-b880-742e56365abe@lunn.ch>
 <10da10caea22a8f5da8f1779df3e13b948e8a363.camel@gmail.com>
 <4abd56aa-5b9f-4e16-b0ca-11989bb8c764@lunn.ch>
 <bff0e542b8c04980e9e3af1d3e6bf739c87eb514.camel@gmail.com>
Message-ID: <a57a216d-ff5a-46e6-9780-e53772dcefc8@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Mar 11, 2023 at 07:49:23AM +0100, Klaus Kudielka wrote:
> On Sat, 2023-03-11 at 00:49 +0100, Andrew Lunn wrote:
> > > Yes, that helps. Primarily, because mdiobus_scan_bus_c45 now is called only once,
> > > and at least some things are done in parallel.
> > 
> > Great. Could you cook up a proper patch and submit it?
> 
> I can give it a try. The commit message will be from my perspective,
> and the change Suggested-By you.

The commit message is fine.

I have one more idea which can speed things up. The scanning of the
MDIO bus works in two different ways depending on if there is a DT
node, describing what should be found on the bus. For mv88e6xxx, using
DT is optional. Some boards do, some don't.

If there is a DT node, only the addresses listed in DT are scanned.

If there is no DT node, by default, all 32 addresses on the bus are
scanned. However, DSA makes another assumption. There is a one to one
mapping between port number and PHY address on the MDIO bus. Port 0
uses MDIO address 0. Port 7 uses MDIO address 7 etc. If you have an 8
port switch, there is no point scanning addresses 8 to 31, they will
never be used.

The mdio bus structure has a member phy_mask. This is a bitmap. If bit
N is set, address N is not scanned. So i suggest you extend
mv88e6xxx_mdio_register() to set phy_mask based on
mv88e6xxx_num_ports(chip).

	Andrew
