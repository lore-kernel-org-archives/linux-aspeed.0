From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 8 Oct 2021 07:27:49 -0500
Subject: [PATCH v3] ARM: dts: aspeed: rainier: Add power-config-full-load
 gpio
In-Reply-To: <20211005192226.213539-1-anoo@linux.ibm.com>
References: <20211005192226.213539-1-anoo@linux.ibm.com>
Message-ID: <897fb30d-966a-f2e0-cf9d-0275f1f1f630@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 10/5/21 2:22 PM, Adriana Kobylak wrote:
> From: Adriana Kobylak <anoo@us.ibm.com>
>
> Add the power-config-full-load described in:
> https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md#power-config-full-load
>
> The power-config-full-load gpio is designed to be used to specify how
> many power supplies the system should have, in rainier it is 2 or 4.  If
> enough power supplies fail so that the system no longer has redundancy
> (no longer n+1), the hardware will signal to the Onboard Chip Controller
> that the system may be oversubscribed, and performance may need to be
> reduced so the system can maintain it's powered on state.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
> ---
>
> v2: Update commit message.
> v3: Updated gpio name to power-config-full-load to match design doc.
>
>   arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index 33fae8ad1305..10bde77fb847 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -1998,6 +1998,19 @@ eeprom at 51 {
>   		reg = <0x51>;
>   	};
>   
> +	pca_pres3: pca9552 at 60 {
> +		compatible = "nxp,pca9552";
> +		reg = <0x60>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		gpio-line-names =
> +			"", "", "", "", "", "", "", "",
> +			"", "", "", "", "", "", "power-config-full-load", "";
> +	};
> +
>   	pca_pres2: pca9552 at 61 {
>   		compatible = "nxp,pca9552";
>   		reg = <0x61>;
