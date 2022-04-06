From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 6 Apr 2022 14:17:33 +0200
Subject: [PATCH v2 2/3] net: mdio: aspeed: Introduce read write function
 for c22 and c45
In-Reply-To: <20220406012002.15128-3-potin.lai@quantatw.com>
References: <20220406012002.15128-1-potin.lai@quantatw.com>
 <20220406012002.15128-3-potin.lai@quantatw.com>
Message-ID: <Yk2E3X7MaJhWi32O@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +static int aspeed_mdio_read(struct mii_bus *bus, int addr, int regnum)
> +{
> +	dev_dbg(&bus->dev, "%s: addr: %d, regnum: %d\n", __func__, addr,
> +		regnum);
> +
> +	if (regnum & MII_ADDR_C45)
> +		return aspeed_mdio_read_c45(bus, addr, regnum);
> +
> +	return aspeed_mdio_read_c22(bus, addr, regnum);
> +}
> +
>  static int aspeed_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val)
>  {
>  	dev_dbg(&bus->dev, "%s: addr: %d, regnum: %d, val: 0x%x\n",
>  		__func__, addr, regnum, val);
>  
> -	/* Just clause 22 for the moment */
>  	if (regnum & MII_ADDR_C45)
> -		return -EOPNOTSUPP;
> +		return aspeed_mdio_write_c45(bus, addr, regnum, val);
>  
> -	return aspeed_mdio_op(bus, ASPEED_MDIO_CTRL_ST_C22, MDIO_C22_OP_WRITE,
> -			      addr, regnum, val);
> +	return aspeed_mdio_write_c22(bus, addr, regnum, val);
>  }

Hi Portin

Nice structure. This will helper with future cleanup where C22 and C45
will be completely separated, and the c45 variants will be directly
passed dev_ad and reg, rather than have to extract them from regnum.

A few process issues.

Please read the netdev FAQ. The subject list should indicate the tree,
and there should be an patch 0/3 which explains the big picture of
what the patchset does. 0/3 will then be used for the merge commit.

     Andrew
