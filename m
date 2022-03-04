From: Patrick Williams <patrick@stwcx.xyz>
Date: Fri, 4 Mar 2022 11:04:35 -0600
Subject: [PATCH 1/1] ARM: dts: aspeed: bletchley: add sample averaging
 for ADM1278
In-Reply-To: <20220304003506.4243-1-potin.lai@quantatw.com>
References: <20220304003506.4243-1-potin.lai@quantatw.com>
Message-ID: <YiJGo7Tor3IKEToq@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 04, 2022 at 08:35:06AM +0800, Potin Lai wrote:
> set number of sample averaging to 128 for both PWR_AVG and VI_AVG
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> index eaf1bc261ee3..be76cd955129 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> @@ -732,6 +732,8 @@
>  		compatible = "adi,adm1278";
>  		reg = <0x11>;
>  		shunt-resistor-micro-ohms = <300>;
> +		adi,volt-curr-sample-average = <128>;
> +		adi,power-sample-average = <128>;
>  	};
>  
>  	tmp421 at 4c {
> -- 
> 2.17.1
> 

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

Note that this code depends on ADM1275 support pulled into groeck/linux-staging
already.

https://lore.kernel.org/all/20220222223610.23098-1-linux at roeck-us.net/

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220304/6422146b/attachment-0001.sig>
