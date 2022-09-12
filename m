From: Patrick Williams <patrick@stwcx.xyz>
Date: Mon, 12 Sep 2022 17:33:16 -0500
Subject: [PATCH v2] ARM: dts: aspeed: yosemitev2: Enable i2c13 controller
In-Reply-To: <20220907123810.GA27621@hcl-ThinkPad-T495>
References: <20220907123810.GA27621@hcl-ThinkPad-T495>
Message-ID: <Yx+zrEViePskgaWq@heinlein.stwcx.org.github.beta.tailscale.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 07, 2022 at 06:08:10PM +0530, Karthikeyan Pasupathi wrote:
> Added IPMB-13 channel for Debug Card communication.

Wouldn't this be better to be the title?  'enable OCP debug card'  Might
need some reference to what an "OCP debug card" is in the commit
message.

> 
> ---
> --- v2-Updated the title
> ---
> 
> ---
> --- v1 - Initial draft.
> ---
> 
> Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> index 8864e9c312a8..84236df522dc 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> @@ -215,6 +215,17 @@
>  	};
>  };
>  
> +&i2c13 {
> +	status = "okay";
> +	// Debug Card
> +	multi-master;
> +	ipmb13 at 10 {
> +		compatible = "ipmb-dev";
> +		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +		i2c-protocol;
> +	};
> +};
> +
>  &pwm_tacho {
>  	status = "okay";
>  	//FSC
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220912/18ab87d7/attachment.sig>
