From: Corey Minyard <minyard@acm.org>
Date: Tue, 2 Nov 2021 19:59:22 -0500
Subject: [PATCH -next v2 0/6] Add LCLK control into Aspeed LPC sub drivers
In-Reply-To: <20211102203717.96794-1-jae.hyun.yoo@intel.com>
References: <20211102203717.96794-1-jae.hyun.yoo@intel.com>
Message-ID: <20211103005922.GN4667@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 02, 2021 at 01:37:11PM -0700, jae.hyun.yoo at intel.com wrote:
> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
> Hello all,
> 
> This series is for appliying below fix to all Aspped LPC sub drivers.
> https://lore.kernel.org/all/20201208091748.1920-1-wangzhiqiang.bj at bytedance.com/

Ok, I've added this to my next tree.

There was some duplicated code between the aspeed and bt files, but I'm
not sure it's enough to matter.

-corey

> 
> An LPC sub driver can be enabled without using the lpc-ctrl driver or it
> can be registered ahead of lpc-ctrl depends on each system configuration and
> this difference introduces that LPC can be enabled without heart beating of
> LCLK so it causes improper handling on host interrupts when the host sends
> interrupts in that time frame. Then kernel eventually forcibly disables the
> interrupt with dumping stack and printing a 'nobody cared this irq' message
> out.
> 
> To prevent this issue, all LPC sub drivers should enable LCLK individually
> so this patch adds clock control logic into the remaining Aspeed LPC sub
> drivers.
> 
> Please review this series.
> 
> Thanks,
> Jae
> 
> Changes sinve v1:
>  - Added 'clocks' property into ibt and kcs-bmc bindings using
>    'aspeed,ast2400-ibt-bmc.txt' and 'aspeed,ast2400-kcs-bmc.yaml'
>    respectively because these are not merged into 'aspeed-lpc.yaml' yet.
>    The bindings merging could be done using a separate patch later.
> 
> Jae Hyun Yoo (6):
>   ARM: dts: aspeed: add LCLK setting into LPC IBT node
>   dt-bindings: ipmi: bt-bmc: add 'clocks' as a required property
>   ipmi: bt: add clock control logic
>   ARM: dts: aspeed: add LCLK setting into LPC KCS nodes
>   dt-bindings: ipmi: aspeed,kcs-bmc: add 'clocks' as a required property
>   ipmi: kcs_bmc_aspeed: add clock control logic
> 
>  .../bindings/ipmi/aspeed,ast2400-ibt-bmc.txt  |  2 ++
>  .../bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml |  7 +++++
>  arch/arm/boot/dts/aspeed-g4.dtsi              |  1 +
>  arch/arm/boot/dts/aspeed-g5.dtsi              |  5 +++
>  arch/arm/boot/dts/aspeed-g6.dtsi              |  5 +++
>  drivers/char/ipmi/bt-bmc.c                    | 24 +++++++++++++-
>  drivers/char/ipmi/kcs_bmc_aspeed.c            | 31 ++++++++++++++++---
>  7 files changed, 70 insertions(+), 5 deletions(-)
> 
> -- 
> 2.25.1
> 
