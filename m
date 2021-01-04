From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date: Mon, 4 Jan 2021 15:30:20 +0000
Subject: [PATCH v3 0/5] Remove LPC register partitioning
In-Reply-To: <20201221055623.31463-1-chiawei_wang@aspeedtech.com>
References: <20201221055623.31463-1-chiawei_wang@aspeedtech.com>
Message-ID: <20210104153020.000015d1@Huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 21 Dec 2020 13:56:18 +0800
"Chia-Wei, Wang" <chiawei_wang@aspeedtech.com> wrote:

> The LPC controller has no concept of the BMC and the Host partitions.
> The incorrect partitioning can impose unnecessary range restrictions
> on register access through the syscon regmap interface.
> 
> For instance, HICRB contains the I/O port address configuration
> of KCS channel 1/2. However, the KCS#1/#2 drivers cannot access
> HICRB as it is located at the other LPC partition.
> 
> In addition, to be backward compatible, the newly added HW control
> bits could be located at any reserved bits over the LPC addressing
> space.
> 
> Thereby, this patch series aims to remove the LPC partitioning for
> better driver development and maintenance. This requires the change
> to both the device tree and the driver implementation. To ensure
> both sides are synchronously updated, a v2 binding check is added.
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
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    |  99 +++----------
>  arch/arm/boot/dts/aspeed-g4.dtsi              |  74 ++++------
>  arch/arm/boot/dts/aspeed-g5.dtsi              | 135 ++++++++----------
>  arch/arm/boot/dts/aspeed-g6.dtsi              | 135 ++++++++----------
>  drivers/char/ipmi/kcs_bmc_aspeed.c            |  35 +++--
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c    |  19 ++-
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c          |  20 ++-
>  drivers/soc/aspeed/aspeed-lpc-snoop.c         |  23 +--
>  8 files changed, 232 insertions(+), 308 deletions(-)
> 
Hi,

New year, new campaign to make people's lives slightly easier :)

I would appreciate it if everyone made sure their cover letters have an
appropriate "scope" defined.   This is going to broad mailing
lists so it would be good to give it a title of something like
"aspeed: Remove LPC register partitioning"
possibly even
"arm: aspeed: Remove LPC register partitioning"

both to make it stand out to people who do want to read it and to
allow others to rapidly conclude they can skip the thread.

Thanks,

Jonathan
