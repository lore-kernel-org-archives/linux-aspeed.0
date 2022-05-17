From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 17 May 2022 13:59:35 +0200
Subject: [PATCH v2 2/3] ARM: dts: aspeed: Add USB2.0 device controller node
In-Reply-To: <20220517082558.3534161-3-neal_liu@aspeedtech.com>
References: <20220517082558.3534161-1-neal_liu@aspeedtech.com>
 <20220517082558.3534161-3-neal_liu@aspeedtech.com>
Message-ID: <96973d1d-c52c-d190-6989-3f7996dae70b@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 17/05/2022 10:25, Neal Liu wrote:
> Add USB2.0 device controller(udc) node to device tree
> for AST2600.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 3d5ce9da42c3..5517313eb2b5 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -298,6 +298,16 @@ vhub: usb-vhub at 1e6a0000 {
>  			status = "disabled";
>  		};
>  
> +		udc: udc at 1e6a2000 {

The same as DTS in bindings - generic node name, please.


Best regards,
Krzysztof
