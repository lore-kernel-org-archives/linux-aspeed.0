From: Cédric Le Goater <clg@kaod.org>
Date: Tue, 12 Nov 2019 09:26:32 +0100
Subject: [PATCH 1/5] ARM: config: aspeed-g5: Enable 8250_DW quirks
In-Reply-To: <20191112062857.32638-2-joel@jms.id.au>
References: <20191112062857.32638-1-joel@jms.id.au>
 <20191112062857.32638-2-joel@jms.id.au>
Message-ID: <4c16fd0d-3746-392f-bb55-ec24bf7f15f7@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/11/2019 07:28, Joel Stanley wrote:
> This driver option is used by the AST2600 A0 boards to work around a
> hardware issue.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: C?dric Le Goater <clg@kaod.org>

> ---
>  arch/arm/configs/aspeed_g5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
> index 597536cc9573..b87508c7056c 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -139,6 +139,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=6
>  CONFIG_SERIAL_8250_EXTENDED=y
>  CONFIG_SERIAL_8250_ASPEED_VUART=y
>  CONFIG_SERIAL_8250_SHARE_IRQ=y
> +CONFIG_SERIAL_8250_DW=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_ASPEED_KCS_IPMI_BMC=y
>  CONFIG_ASPEED_BT_IPMI_BMC=y
> 

