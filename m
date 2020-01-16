From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 16 Jan 2020 10:57:31 +0100
Subject: [PATCH 1/2] clk: aspeed: add critical clock setting logic
In-Reply-To: <20200115212639.4998-2-jae.hyun.yoo@linux.intel.com>
References: <20200115212639.4998-1-jae.hyun.yoo@linux.intel.com>
 <20200115212639.4998-2-jae.hyun.yoo@linux.intel.com>
Message-ID: <3cafc96a-0ec5-d51c-94cc-2b2e41cc5c65@molgen.mpg.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Jae,


On 2020-01-15 22:26, Jae Hyun Yoo wrote:
> This commit adds critical clock setting logic that applies
> CLK_IS_CRITICAL flag if it detects 'clock-critical' property in
> device tree.

Tested how?

> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/clk/clk-aspeed.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 411ff5fb2c07..d22eeb574ede 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -541,8 +541,11 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < ARRAY_SIZE(aspeed_gates); i++) {
>  		const struct aspeed_gate_data *gd = &aspeed_gates[i];
> +		unsigned long flags = gd->flags;
>  		u32 gate_flags;
>  
> +		of_clk_detect_critical(pdev->dev.of_node, i, &flags);
> +

The function description in `drivers/clk/clk.c` has the warning below.

>  * Do not use this function. It exists only for legacy Device Tree
>  * bindings, such as the one-clock-per-node style that are outdated.
>  * Those bindings typically put all clock data into .dts and the Linux
>  * driver has no clock data, thus making it impossible to set this flag
>  * correctly from the driver. Only those drivers may call
>  * of_clk_detect_critical from their setup functions.

Will this still work?

>  		/* Special case: the USB port 1 clock (bit 14) is always
>  		 * working the opposite way from the other ones.
>  		 */
> @@ -550,7 +553,7 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>  		hw = aspeed_clk_hw_register_gate(dev,
>  				gd->name,
>  				gd->parent_name,
> -				gd->flags,
> +				flags,
>  				map,
>  				gd->clock_idx,
>  				gd->reset_idx,


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200116/a87f0f3e/attachment.bin>
