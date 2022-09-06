From: Tao Ren <rentao.bupt@gmail.com>
Date: Mon, 5 Sep 2022 23:27:42 -0700
Subject: [PATCH v1] Update for Facebook yosemite V2 BMC.
In-Reply-To: <20220906050702.GA10565@hcl-ThinkPad-T495>
References: <20220906050702.GA10565@hcl-ThinkPad-T495>
Message-ID: <YxboXspF+0Y/+spD@taoren-fedora-PC23YAB4>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Karthikeyan,

I don't have much experience with ipmb-dev, but I'd suggest updating the
patch tile so it's consistent with other dts patches. For example:

"ARM: dts: aspeed: yosemitev2: Enable i2c13 controller"


Cheers,

- Tao

On Tue, Sep 06, 2022 at 10:37:02AM +0530, Karthikeyan Pasupathi wrote:
> Added IPMB-13 channel for Debug Card communication.
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
