From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 11 Mar 2023 18:57:27 +0100
Subject: [PATCH net-next v2 4/6] net: mdio: scan bus based on bus
 capabilities for C22 and C45
In-Reply-To: <49a9154ae4e2b3e6bc85e560368f6474f97cea88.camel@gmail.com>
References: <0e10aa8492eadb587949d8744b56fccaabbd183b.camel@gmail.com>
 <72530e86-9ba9-4a01-9cd2-68835ecae7a0@lunn.ch>
 <09d65e1ee0679e1e74b4f3a5a4c55bd48332f043.camel@gmail.com>
 <70f5bca0-322c-4bae-b880-742e56365abe@lunn.ch>
 <10da10caea22a8f5da8f1779df3e13b948e8a363.camel@gmail.com>
 <4abd56aa-5b9f-4e16-b0ca-11989bb8c764@lunn.ch>
 <bff0e542b8c04980e9e3af1d3e6bf739c87eb514.camel@gmail.com>
 <a57a216d-ff5a-46e6-9780-e53772dcefc8@lunn.ch>
 <2f64385a350359c5755eb4d2479e2efef7a96216.camel@gmail.com>
 <49a9154ae4e2b3e6bc85e560368f6474f97cea88.camel@gmail.com>
Message-ID: <f70aa0ea-5d8e-4cc3-bd5e-5b4a79d67281@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Well, maybe I misunderstood the argument with DT completely, so I gave it a try:
> 
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -3797,6 +3797,7 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
>         bus->read_c45 = mv88e6xxx_mdio_read_c45;
>         bus->write_c45 = mv88e6xxx_mdio_write_c45;
>         bus->parent = chip->dev;
> +       bus->phy_mask = GENMASK(31, mv88e6xxx_num_ports(chip));
>  
>         if (!external) {
>                 err = mv88e6xxx_g2_irq_mdio_setup(chip, bus);
> 
> > 
> 
> Now THAT one makes a difference! With this on top, I'm back at normal boot time!
> I hope this is what you had in mind?

Yep, that is what i meant. Please could you also submit a patch for this?

     Andrew

