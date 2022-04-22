From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 22 Apr 2022 12:25:18 -0700
Subject: [PATCH net-next RESEND v5 0/3] Add reset deassertion for Aspeed
 MDIO
In-Reply-To: <20220418014059.3054-1-dylan_hung@aspeedtech.com>
References: <20220418014059.3054-1-dylan_hung@aspeedtech.com>
Message-ID: <20220422122518.347d7779@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 18 Apr 2022 09:40:56 +0800 Dylan Hung wrote:
> Add missing reset deassertion for Aspeed MDIO bus controller. The reset
> is asserted by the hardware when power-on so the driver only needs to
> deassert it. To be able to work with the old DT blobs, the reset is
> optional since it may be deasserted by the bootloader or the previous
> kernel.

still doesn't apply cleanly to net-next:

$ git checkout net-next/master 
HEAD is now at c78c5a660439 dt-bindings: net: mediatek,net: convert to the json-schema

$ git pw series apply 632891
Applying: dt-bindings: net: add reset property for aspeed, ast2600-mdio binding
Applying: net: mdio: add reset control for Aspeed MDIO
Using index info to reconstruct a base tree...
M	drivers/net/mdio/mdio-aspeed.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/mdio/mdio-aspeed.c
Applying: ARM: dts: aspeed: add reset properties into MDIO nodes
