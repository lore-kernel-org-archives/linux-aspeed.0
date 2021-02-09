From: Stephen Boyd <sboyd@kernel.org>
Date: Mon, 08 Feb 2021 23:36:39 -0800
Subject: [PATCH v2 1/1] media: aspeed: fix clock handling logic
In-Reply-To: <20201221223225.14723-2-jae.hyun.yoo@linux.intel.com>
References: <20201221223225.14723-1-jae.hyun.yoo@linux.intel.com>
 <20201221223225.14723-2-jae.hyun.yoo@linux.intel.com>
Message-ID: <161285619930.76967.620222959363595605@swboyd.mtv.corp.google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Jae Hyun Yoo (2020-12-21 14:32:25)
> Video engine uses eclk and vclk for its clock sources and its reset
> control is coupled with eclk so the current clock enabling sequence works
> like below.
> 
>  Enable eclk
>  De-assert Video Engine reset
>  10ms delay
>  Enable vclk
> 
> It introduces improper reset on the Video Engine hardware and eventually
> the hardware generates unexpected DMA memory transfers that can corrupt
> memory region in random and sporadic patterns. This issue is observed
> very rarely on some specific AST2500 SoCs but it causes a critical
> kernel panic with making a various shape of signature so it's extremely
> hard to debug. Moreover, the issue is observed even when the video
> engine is not actively used because udevd turns on the video engine
> hardware for a short time to make a query in every boot.
> 
> To fix this issue, this commit changes the clock handling logic to make
> the reset de-assertion triggered after enabling both eclk and vclk. Also,
> it adds clk_unprepare call for a case when probe fails.
> 
> Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Eddie James <eajames@linux.ibm.com>
> 
> clk: ast2600: fix reset settings for eclk and vclk
> 
> Video engine reset setting should be coupled with eclk to match it
> with the setting for previous Aspeed SoCs which is defined in
> clk-aspeed.c since all Aspeed SoCs are sharing a single video engine
> driver. Also, reset bit 6 is defined as 'Video Engine' reset in
> datasheet so it should be de-asserted when eclk is enabled. This
> commit fixes the setting.
> 
> Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
