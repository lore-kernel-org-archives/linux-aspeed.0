From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 7 Sep 2022 11:44:03 -0700
Subject: [PATCH net-next v3 2/2] ARM: dts: aspeed: elbert: Enable mac3
 controller
In-Reply-To: <20220907054453.20016-3-rentao.bupt@gmail.com>
References: <20220907054453.20016-1-rentao.bupt@gmail.com>
 <20220907054453.20016-3-rentao.bupt@gmail.com>
Message-ID: <7f3a2e42-6214-c41f-90f7-53ee637a720d@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 9/6/2022 10:44 PM, rentao.bupt at gmail.com wrote:
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

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
