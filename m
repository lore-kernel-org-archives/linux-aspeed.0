From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Jul 2024 09:59:51 +0200
Subject: [PATCH v2 2/2] ARM: dts: aspeed: catalina: add Meta Catalina BMC
In-Reply-To: <20240724-potin-catalina-dts-v2-2-ba8d475c4073@gmail.com>
References: <20240724-potin-catalina-dts-v2-0-ba8d475c4073@gmail.com>
 <20240724-potin-catalina-dts-v2-2-ba8d475c4073@gmail.com>
Message-ID: <f691d555-839c-4f80-9097-eac27823a35c@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 24/07/2024 09:41, Potin Lai wrote:
> Add linux device tree entry for Meta(Facebook) Catalina compute-tray
> BMC using AT2600 SoC.
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>

Thank you for your patch. There is something to discuss/improve.

> +		i2c1mux0ch4: i2c at 4 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x4>;
> +
> +			power-monitor at 42 {
> +				compatible = "lltc,ltc4287";
> +				reg = <0x42>;
> +				shunt-resistor-micro-ohms = <200>;
> +			};
> +			power-monitor at 43 {
> +				compatible = "lltc,ltc4287";
> +				reg = <0x43>;
> +				shunt-resistor-micro-ohms = <200>;
> +			};
> +		};
> +		i2c1mux0ch5: i2c at 5 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x5>;
> +
> +			// PDB FRU EEPROM
> +			eeprom at 54 {
> +				compatible = "atmel,24c64";
> +				reg = <0x54>;
> +			};
> +
> +			// PDB TEMP SENSOR
> +			tmp75 at 4f {

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation



Best regards,
Krzysztof

