From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 7 Sep 2022 20:31:24 +0200
Subject: [PATCH net-next v3 2/2] ARM: dts: aspeed: elbert: Enable mac3
 controller
In-Reply-To: <20220907054453.20016-3-rentao.bupt@gmail.com>
References: <20220907054453.20016-1-rentao.bupt@gmail.com>
 <20220907054453.20016-3-rentao.bupt@gmail.com>
Message-ID: <YxjjfELmf7XIVH7k@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 06, 2022 at 10:44:53PM -0700, rentao.bupt at gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Enable mac3 controller in Elbert dts: Elbert MAC3 is connected to the
> BCM53134P onboard switch's IMP_RGMII port directly (fixed link, no PHY
> between BMC MAC and BCM53134P).
> 
> Note: BMC's mdio0 controller is connected to BCM53134P's MDIO interface,
> and the MDIO channel will be enabled later, when BCM53134 is added to
> "bcm53xx" DSA driver.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
