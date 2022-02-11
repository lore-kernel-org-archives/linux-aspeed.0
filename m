From: Patrick Williams <patrick@stwcx.xyz>
Date: Fri, 11 Feb 2022 16:19:36 -0600
Subject: [PATCH 10/10] arch: arm: dts: bletchley: cleanup redundant node
In-Reply-To: <20220211014347.24841-11-potin.lai@quantatw.com>
References: <20220211014347.24841-1-potin.lai@quantatw.com>
 <20220211014347.24841-11-potin.lai@quantatw.com>
Message-ID: <Ygbg+KYK9qT90O2N@heinlein>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 11, 2022 at 09:43:47AM +0800, Potin Lai wrote:
> Remove redundant i2c1 node.
> Disable in-chip rtc, use external rtc (pcf85263) instead.

A bit of "why" on the RTC change might be useful.  I suspect it has to do
with where battery-backing is for the RTC in hardware.

> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> index 946107bd8bc7..fb62a67cfeed 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> @@ -205,10 +205,6 @@
>  	};
>  };
>  
> -&rtc {
> -	status = "okay";
> -};
> -
>  &fmc {
>  	status = "okay";
>  	flash at 0 {
> @@ -387,10 +383,6 @@
>  	};
>  };
>  
> -&i2c1 {
> -	status = "okay";
> -};
> -
>  &i2c2 {
>  	status = "okay";
>  	ina230 at 45 {
> @@ -680,6 +672,7 @@
>  	};
>  
>  	rtc at 51 {
> +		/* in-chip rtc disabled, use this external rtc instead */
>  		compatible = "nxp,pcf85263";
>  		reg = <0x51>;
>  	};
> -- 
> 2.17.1
> 

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220211/d38df7a4/attachment.sig>
