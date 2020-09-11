From: Joel Stanley <joel@jms.id.au>
Date: Fri, 11 Sep 2020 04:03:11 +0000
Subject: [PATCH 0/4] Remove LPC register partitioning
In-Reply-To: <20200911034631.8473-1-chiawei_wang@aspeedtech.com>
References: <20200911034631.8473-1-chiawei_wang@aspeedtech.com>
Message-ID: <CACPK8XcYvUj3W-CPzXKugp3wx7rcLEJ_8f2-Bi6V7QHZpopBbA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Fri, 11 Sep 2020 at 03:46, Chia-Wei, Wang
<chiawei_wang@aspeedtech.com> wrote:
>
> The LPC controller has no concept of the BMC and the Host partitions.
> The incorrect partitioning can impose unnecessary range restrictions
> on register access through the syscon regmap interface.
>
> For instance, HICRB contains the I/O port address configuration
> of KCS channel 1/2. However, the KCS#1/#2 drivers cannot access
> HICRB as it is located at the other LPC partition.
>
> In addition, to be backward compatible, the newly added HW control
> bits could be added at any reserved bits over the LPC addressing space.
>
> Thereby, this patch series aims to remove the LPC partitioning for
> better driver development and maintenance.

I support this cleanup. The only consideration is to be careful with
breaking the driver/device-tree relationship. We either need to ensure
the drivers remain compatible with  both device trees.

Another solution is to get agreement from all parties that for the LPC
device the device tree is always the one shipped with the kernel, so
it is okay to make incompatible changes.

While we are doing a cleanup, Andrew suggested we remove the detailed
description of LPC out of the device tree. We would have the one LPC
node, and create a LPC driver that creates all of the sub devices
(snoop, FW cycles, kcs, bt, vuart). Andrew, can  you elaborate on this
plan?

Cheers,

Joel


>
> Chia-Wei, Wang (4):
>   ARM: dts: Remove LPC BMC and Host partitions
>   soc: aspeed: Fix LPC register offsets
>   ipmi: kcs: aspeed: Fix LPC register offsets
>   pinctrl: aspeed-g5: Fix LPC register offsets
>
>  arch/arm/boot/dts/aspeed-g4.dtsi           |  74 +++++------
>  arch/arm/boot/dts/aspeed-g5.dtsi           | 135 +++++++++------------
>  arch/arm/boot/dts/aspeed-g6.dtsi           | 135 +++++++++------------
>  drivers/char/ipmi/kcs_bmc_aspeed.c         |  13 +-
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c |   2 +-
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c       |   6 +-
>  drivers/soc/aspeed/aspeed-lpc-snoop.c      |  11 +-
>  7 files changed, 162 insertions(+), 214 deletions(-)
>
> --
> 2.17.1
>
