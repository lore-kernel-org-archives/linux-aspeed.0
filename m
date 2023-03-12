From: Klaus Kudielka <klaus.kudielka@gmail.com>
Date: Sun, 12 Mar 2023 10:04:11 +0100
Subject: [PATCH net-next v2 4/6] net: mdio: scan bus based on bus
 capabilities for C22 and C45
In-Reply-To: <29ee3cc4-a1d6-4a07-8d90-4b2f26059e7d@lunn.ch>
References: <db6b8a09-b680-4baa-8963-d355ad29eb09@lunn.ch>
	 <0e10aa8492eadb587949d8744b56fccaabbd183b.camel@gmail.com>
	 <72530e86-9ba9-4a01-9cd2-68835ecae7a0@lunn.ch>
	 <09d65e1ee0679e1e74b4f3a5a4c55bd48332f043.camel@gmail.com>
	 <70f5bca0-322c-4bae-b880-742e56365abe@lunn.ch>
	 <10da10caea22a8f5da8f1779df3e13b948e8a363.camel@gmail.com>
	 <4abd56aa-5b9f-4e16-b0ca-11989bb8c764@lunn.ch>
	 <bff0e542b8c04980e9e3af1d3e6bf739c87eb514.camel@gmail.com>
	 <a57a216d-ff5a-46e6-9780-e53772dcefc8@lunn.ch>
	 <2f64385a350359c5755eb4d2479e2efef7a96216.camel@gmail.com>
	 <29ee3cc4-a1d6-4a07-8d90-4b2f26059e7d@lunn.ch>
Message-ID: <0a1ec04fe494fcd8c68d03e4f544d7162c0e4f39.camel@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, 2023-03-12 at 03:53 +0100, Andrew Lunn wrote:
> > 
> > What you are proposing here would not show any improvement on the
> > Omnia, as only the 6 ports would be scanned - right? 
> 
> Correct. But their also should not of been any noticeable slow down,
> because there should not be any additional scanning when everything is
> described in DT. And the move of the MDIO bus registration from probe
> to setup should actually make it faster than before.
> 

But then, why *do* I see such a big difference on the Omnia?

mdiobus_scan_bus_c45() takes:
~2.7 seconds without phy_mask patch
~0.2 seconds with phy_mask patch

(It's not a big deal, but somehow strange)

Regards, Klaus


PS: There was another open question: How long does the first
unsuccessful mv88e6xxx_probe() take, when calling
mv88e6xxx_mdios_register() from mv88e6xxx_setup()?

I would say "negligible":

[    0.194414] mv88e6085 f1072004.mdio-mii:10: *** mv88e6xxx_probe call ***
[    0.194739] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marvell 88E6176, revision 1
[    0.208163] mv88e6085 f1072004.mdio-mii:10: *** mv88e6xxx_probe return -517 ***

