From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 19 Jan 2023 15:32:02 +1030
Subject: [PATCH net-next v2 6/6] net: phy: Remove probe_capabilities
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v2-6-15513b05e1f4@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v2-0-15513b05e1f4@walle.cc>
 <20230116-net-next-remove-probe-capabilities-v2-6-15513b05e1f4@walle.cc>
Message-ID: <61140466-6195-4309-8f46-3edf084731c2@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 18 Jan 2023, at 20:31, Michael Walle wrote:
> From: Andrew Lunn <andrew@lunn.ch>
>
> Deciding if to probe of PHYs using C45 is now determine by if the bus
> provides the C45 read method. This makes probe_capabilities redundant
> so remove it.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/adi/adin1110.c               | 1 -
>  drivers/net/ethernet/freescale/xgmac_mdio.c       | 1 -
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c       | 1 -
>  drivers/net/ethernet/microchip/lan743x_main.c     | 2 --
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 3 ---
>  drivers/net/mdio/mdio-aspeed.c                    | 1 -

For the Aspeed change:

Acked-by: Andrew Jeffery <andrew@aj.id.au>
