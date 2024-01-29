From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 29 Jan 2024 16:46:04 +0100
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: add mac config for
 Yosemite 4
In-Reply-To: <20240118060041.1923700-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240118060041.1923700-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <70f31372-7840-47e0-ba4d-d1b4896928d3@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 18/01/2024 07:00, Delphine CC Chiu wrote:
> Add start-redo-probe and no-channel-monitor property in mac config
> to fix Mellanox cx7 nic card cannot't get mac address after nic card
> re-plug.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 64075cc41d92..33c01d79e5e0 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -89,6 +89,8 @@ &mac2 {
>  	pinctrl-0 = <&pinctrl_rmii3_default>;
>  	use-ncsi;
>  	mlx,multi-host;
> +	ncsi-ctrl,start-redo-probe;
> +	ncsi-ctrl,no-channel-monitor;

There are no such properties.

NAK

Best regards,
Krzysztof

