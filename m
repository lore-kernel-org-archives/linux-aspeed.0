From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 28 Mar 2022 13:47:43 +1030
Subject: [PATCH v2 4/5] ARM: dts: aspeed-g6: add FWQSPI group in pinctrl
 dtsi
In-Reply-To: <20220325154048.467245-5-quic_jaehyoo@quicinc.com>
References: <20220325154048.467245-1-quic_jaehyoo@quicinc.com>
 <20220325154048.467245-5-quic_jaehyoo@quicinc.com>
Message-ID: <c681079b-5bc7-4c96-b68b-77214f64a165@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 26 Mar 2022, at 02:10, Jae Hyun Yoo wrote:
> From: Johnny Huang <johnny_huang@aspeedtech.com>
>
> Add FWSPIDQ2 and FWSPIDQ3 group to support AST2600 FW SPI quad mode.
> These pins can be used with dedicated FW SPI pins - FWSPICS0#,
> FWSPICK, FWSPIMOSI and FWSPIMISO.
>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> ---
> Changes in v2:
>  * None.
>
>  arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi 
> b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> index 06d60a8540e9..47c3fb137cbc 100644
> --- a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> @@ -117,6 +117,11 @@ pinctrl_fwspid_default: fwspid_default {
>  		groups = "FWSPID";
>  	};
> 
> +	pinctrl_fwqspi_default: fwqspi_default {
> +		function = "FWQSPI";
> +		groups = "FWQSPI";
> +	};
> +

This is okay once you update the binding documentation.

Andrew
