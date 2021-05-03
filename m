From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 03 May 2021 14:37:47 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_2/3]_ARM:_dts:_aspeed:_ast2600evb:_Add_timing-ph?=
 =?UTF-8?Q?ase_property_for_eMMC_controller?=
In-Reply-To: <20210503014336.20256-3-steven_lee@aspeedtech.com>
References: <20210503014336.20256-1-steven_lee@aspeedtech.com>
 <20210503014336.20256-3-steven_lee@aspeedtech.com>
Message-ID: <f237a53e-ad61-469a-a19f-8a1e52c6cfba@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Steven,

On Mon, 3 May 2021, at 11:13, Steven Lee wrote:
> Set eMMC input clock phase to 3, which is more stable on AST2600 EVBs.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts 
> b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> index 2772796e215e..7a93317e27dc 100644
> --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -102,6 +102,7 @@
>  
>  &emmc_controller {
>  	status = "okay";
> +	timing-phase = <0x300FF>;

Please use the existing binding for phase corrections. The existing 
binding is already supported by the driver (added in v5.12).

Andrew
