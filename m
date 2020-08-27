From: Tero Kristo <t-kristo@ti.com>
Date: Thu, 27 Aug 2020 10:13:16 +0300
Subject: [PATCH 2/2] EDAC/ti: Fix handling of platform_get_irq() error
In-Reply-To: <20200827070743.26628-2-krzk@kernel.org>
References: <20200827070743.26628-1-krzk@kernel.org>
 <20200827070743.26628-2-krzk@kernel.org>
Message-ID: <1a92f43b-5358-169f-7dd8-1860a26d9861@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27/08/2020 10:07, Krzysztof Kozlowski wrote:
> platform_get_irq() returns -ERRNO on error.  In such case comparison
> to 0 would pass the check.
> 
> Fixes: 86a18ee21e5e ("EDAC, ti: Add support for TI keystone and DRA7xx EDAC")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Tero Kristo <t-kristo@ti.com>

> ---
>   drivers/edac/ti_edac.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
> index 6e52796a0b41..e7eae20f83d1 100644
> --- a/drivers/edac/ti_edac.c
> +++ b/drivers/edac/ti_edac.c
> @@ -278,7 +278,8 @@ static int ti_edac_probe(struct platform_device *pdev)
>   
>   	/* add EMIF ECC error handler */
>   	error_irq = platform_get_irq(pdev, 0);
> -	if (!error_irq) {
> +	if (error_irq < 0) {
> +		ret = error_irq;
>   		edac_printk(KERN_ERR, EDAC_MOD_NAME,
>   			    "EMIF irq number not defined.\n");
>   		goto err;
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
