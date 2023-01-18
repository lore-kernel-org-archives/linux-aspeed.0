From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 17 Jan 2023 17:07:36 -0800
Subject: [PATCH net-next 3/6] net: mdio: Add workaround for Micrel PHYs
 which are not C45 compatible
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v1-3-5aa29738a023@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
 <20230116-net-next-remove-probe-capabilities-v1-3-5aa29738a023@walle.cc>
Message-ID: <feb36396-74ec-06c1-9d91-9c980d0775e7@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/16/2023 4:55 AM, Michael Walle wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> After scanning the bus for C22 devices, check if any Micrel PHYs have
> been found.  They are known to do bad things if there are C45
> transactions on the bus. Prevent the scanning of the bus using C45 if
> such a PHY has been detected.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

...

> @@ -600,6 +601,31 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
>   	return 0;
>   }
>   
> +/* There are some C22 PHYs which do bad things when where is a C45
> + * transaction on the bus, like accepting a read themselves, and
> + * stomping over the true devices reply, to performing a write to
> + * themselves which was intended for another device. Now that C22
> + * devices have been found, see if any of them are bad for C45, and if we
> + * should skip the C45 scan.
> + */
> +static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
> +{
> +	struct phy_device *phydev;
> +	u32 oui;

nit: phydev and oui declarations can move inside the loop

> +	int i;
> +
> +	for (i = 0; i < PHY_MAX_ADDR; i++) {
> +		phydev = mdiobus_get_phy(bus, i);
> +		if (!phydev)
> +			continue;
> +		oui = phydev->phy_id >> 10;
> +
> +		if (oui == MICREL_OUI)
> +			return true;
> +	}
> +	return false;
> +}
> +
>   /**
>    * __mdiobus_register - bring up all the PHYs on a given bus and attach them to bus
>    * @bus: target mii_bus

