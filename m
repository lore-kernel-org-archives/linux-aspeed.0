From: Patrick Williams <patrick@stwcx.xyz>
Date: Mon, 12 Sep 2022 17:32:00 -0500
Subject: [PATCH v2] ARM: dts: aspeed: yosemit V2: Update for Facebook
 Yosemite V2 BMC
In-Reply-To: <20220907125035.GA28461@hcl-ThinkPad-T495>
References: <20220907125035.GA28461@hcl-ThinkPad-T495>
Message-ID: <Yx+zYP5qTuDrjP10@heinlein.stwcx.org.github.beta.tailscale.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 07, 2022 at 06:20:35PM +0530, Karthikeyan Pasupathi wrote:

Please improve the title and commit message here.  "Update" is
insufficient for a title.  There is no description of _why_ in the commit
message.

> Removed NIC EEPROM driver IPMB-12 channel and keeping it as
> "status ok".
> 
> ---
> --- v2- Updated the title
> ---
> 
> ---
> --- v1- Initial draft
> ---
> 
> Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> index 8864e9c312a8..2293f10e94d6 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> @@ -207,12 +207,6 @@
>  
>  &i2c12 {
>  	status = "okay";
> -	//MEZZ_FRU
> -	eeprom at 51 {
> -		compatible = "atmel,24c64";
> -		reg = <0x51>;
> -		pagesize = <32>;
> -	};
>  };
>  
>  &pwm_tacho {
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220912/7e2f7d29/attachment.sig>
