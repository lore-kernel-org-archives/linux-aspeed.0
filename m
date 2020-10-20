From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Tue, 20 Oct 2020 06:03:32 +0000
Subject: [PATCH v2 0/5] Remove LPC register partitioning
In-Reply-To: <20201005082806.28899-1-chiawei_wang@aspeedtech.com>
References: <20201005082806.28899-1-chiawei_wang@aspeedtech.com>
Message-ID: <HK0PR06MB377943740366AB328247C452911F0@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi All,

Do you have any comment on the v2 changes?
Thanks.

Chiawei

> -----Original Message-----
> From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> Sent: Monday, October 5, 2020 4:28 PM
> To: lee.jones at linaro.org; robh+dt at kernel.org; joel at jms.id.au;
> andrew at aj.id.au; minyard at acm.org; arnd at arndb.de;
> gregkh at linuxfoundation.org; linus.walleij at linaro.org;
> haiyue.wang at linux.intel.com; cyrilbur at gmail.com; rlippert at google.com;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-kernel at vger.kernel.org; openbmc at lists.ozlabs.org;
> linux-gpio at vger.kernel.org
> Subject: [PATCH v2 0/5] Remove LPC register partitioning
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
> development and maintenance.
> 
> 
> Changes since v1:
> 	- Add the fix to the aspeed-lpc binding documentation.
> 
> Chia-Wei, Wang (5):
>   ARM: dts: Remove LPC BMC and Host partitions
>   soc: aspeed: Fix LPC register offsets
>   ipmi: kcs: aspeed: Fix LPC register offsets
>   pinctrl: aspeed-g5: Fix LPC register offsets
>   dt-bindings: aspeed-lpc: Remove LPC partitioning
> 
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    |  85 ++---------
>  arch/arm/boot/dts/aspeed-g4.dtsi              |  74 ++++------
>  arch/arm/boot/dts/aspeed-g5.dtsi              | 135 ++++++++----------
>  arch/arm/boot/dts/aspeed-g6.dtsi              | 135 ++++++++----------
>  drivers/char/ipmi/kcs_bmc_aspeed.c            |  13 +-
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c    |   2 +-
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c          |   6 +-
>  drivers/soc/aspeed/aspeed-lpc-snoop.c         |  11 +-
>  8 files changed, 176 insertions(+), 285 deletions(-)
> 
> --
> 2.17.1

