From: Klaus Kudielka <klaus.kudielka@gmail.com>
Date: Sat, 11 Mar 2023 18:32:54 +0100
Subject: [PATCH net-next v2 4/6] net: mdio: scan bus based on bus
 capabilities for C22 and C45
In-Reply-To: <2f64385a350359c5755eb4d2479e2efef7a96216.camel@gmail.com>
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
	 <a57a216d-ff5a-46e6-9780-e53772dcefc8@lunn.ch>
	 <2f64385a350359c5755eb4d2479e2efef7a96216.camel@gmail.com>
Message-ID: <49a9154ae4e2b3e6bc85e560368f6474f97cea88.camel@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2023-03-11 at 17:11 +0100, Klaus Kudielka wrote:
> On Sat, 2023-03-11 at 16:39 +0100, Andrew Lunn wrote:
> 
> > If there is no DT node, by default, all 32 addresses on the bus are
> > scanned. However, DSA makes another assumption. There is a one to one
> > mapping between port number and PHY address on the MDIO bus. Port 0
> > uses MDIO address 0. Port 7 uses MDIO address 7 etc. If you have an 8
> > port switch, there is no point scanning addresses 8 to 31, they will
> > never be used.
> > 
> > The mdio bus structure has a member phy_mask. This is a bitmap. If bit
> > N is set, address N is not scanned. So i suggest you extend
> > mv88e6xxx_mdio_register() to set phy_mask based on
> > mv88e6xxx_num_ports(chip).
> > 
> 
> What you are proposing here would not show any improvement on the
> Omnia, as only the 6 ports would be scanned - right? 
> 

Well, maybe I misunderstood the argument with DT completely, so I gave it a try:

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3797,6 +3797,7 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
        bus->read_c45 = mv88e6xxx_mdio_read_c45;
        bus->write_c45 = mv88e6xxx_mdio_write_c45;
        bus->parent = chip->dev;
+       bus->phy_mask = GENMASK(31, mv88e6xxx_num_ports(chip));
 
        if (!external) {
                err = mv88e6xxx_g2_irq_mdio_setup(chip, bus);

> 

Now THAT one makes a difference! With this on top, I'm back at normal boot time!
I hope this is what you had in mind?

Best regards, Klaus

