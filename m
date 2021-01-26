From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Tue, 26 Jan 2021 05:51:54 +0000
Subject: [PATCH v5 0/5] Remove LPC register partitioning
In-Reply-To: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
Message-ID: <HK0PR06MB377998280F185FC90D98A63E91BC0@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thank you all for the reviewing effort.

Hi Joel,

Would you help to merge these patches into Aspeed tree?
If yes, we should also notify Linus Walleij to apply the pinctrl one to the pinctrl tree.

Thanks,
Chiawei

> -----Original Message-----
> From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> Sent: Thursday, January 14, 2021 9:16 PM
> To: robh+dt at kernel.org; lee.jones at linaro.org; joel at jms.id.au;
> andrew at aj.id.au; linus.walleij at linaro.org; minyard at acm.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> openbmc at lists.ozlabs.org
> Cc: BMC-SW <BMC-SW@aspeedtech.com>; haiyue.wang at linux.intel.com;
> cyrilbur at gmail.com; rlippert at google.com
> Subject: [PATCH v5 0/5] Remove LPC register partitioning
> 
> The LPC controller has no concept of the BMC and the Host partitions.
> The incorrect partitioning can impose unnecessary range restrictions on
> register access through the syscon regmap interface.
> 
> For instance, HICRB contains the I/O port address configuration of KCS channel
> 1/2. However, the KCS#1/#2 drivers cannot access HICRB as it is located at the
> other LPC partition.
> 
> In addition, to be backward compatible, the newly added HW control bits could
> be located at any reserved bits over the LPC addressing space.
> 
> Thereby, this patch series aims to remove the LPC partitioning for better driver
> development and maintenance. This requires the change to both the device
> tree and the driver implementation. To ensure both sides are synchronously
> updated, a v2 binding check is added.
> 
> Chagnes since v4:
> 	- Add child node example in dt-bindings.
> 
> Chagnes since v3:
> 	- Revise binding check as suggested by Haiyue Wang.
> 
> Changes since v2:
> 	- Add v2 binding check to ensure the synchronization between the
> 	  device tree change and the driver register offset fix.
> 
> Changes since v1:
> 	- Add the fix to the aspeed-lpc binding documentation.
> 
> Chia-Wei, Wang (5):
>   dt-bindings: aspeed-lpc: Remove LPC partitioning
>   ARM: dts: Remove LPC BMC and Host partitions
>   ipmi: kcs: aspeed: Adapt to new LPC DTS layout
>   pinctrl: aspeed-g5: Adapt to new LPC device tree layout
>   soc: aspeed: Adapt to new LPC device tree layout
> 
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 100 ++++---------
>  arch/arm/boot/dts/aspeed-g4.dtsi              |  74 ++++------
>  arch/arm/boot/dts/aspeed-g5.dtsi              | 135 ++++++++----------
>  arch/arm/boot/dts/aspeed-g6.dtsi              | 135 ++++++++----------
>  drivers/char/ipmi/kcs_bmc_aspeed.c            |  27 ++--
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c    |  17 ++-
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c          |  20 ++-
>  drivers/soc/aspeed/aspeed-lpc-snoop.c         |  23 +--
>  8 files changed, 229 insertions(+), 302 deletions(-)
> 
> --
> 2.17.1

