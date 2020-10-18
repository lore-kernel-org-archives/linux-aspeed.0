From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 18 Oct 2020 11:55:49 +0100
Subject: [PATCH 3/3] iio: adc: aspeed: Setting ref_voltage in probe
In-Reply-To: <20201013103245.16723-4-billy_tsai@aspeedtech.com>
References: <20201013103245.16723-1-billy_tsai@aspeedtech.com>
 <20201013103245.16723-4-billy_tsai@aspeedtech.com>
Message-ID: <20201018115549.6b1f871a@archlinux>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2020 18:32:45 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> At ast2600 ref_voltage becomes configurable and this property is board
> dependency.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

dt-bindings: etc for the patch title.  Look at naming of similar patches
for a reference.


> ---
>  .../devicetree/bindings/iio/adc/aspeed_adc.txt   | 16 +++++++++++++++-

This has been converted to yaml. 
It is now in Linus' tree (though only very recently!)

You will need to add the relevant logic to make the yaml binding express that this
only exists and is required for ast600

The binding is making me wonder a bit on what this voltage actually is...

I 'think' we have a setup where the reference voltage is either picked
from 2 available internal references or uses an external regulator (presumably
provided to a pin on the chip?)

As such, the binding should be an optional regulator.  If the regulator is present
we use that, even if it matches the internal regulator votlage.  Someone put it
down on the board, so presumably  they want to use it.

If it's not present, then have to provide either of the two internal regulator
voltages via a devicetree binding such as you have here.



>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> index 034fc2ba100e..0ba1980c4e06 100644
> --- a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> @@ -3,8 +3,11 @@ Aspeed ADC
>  This device is a 10-bit converter for 16 voltage channels.  All inputs are
>  single ended.
>  
> +At ast2600, this device split into two individual IPs and each contains 8 voltage channels.
> +
> +Chip level dtsi:
>  Required properties:
> -- compatible: Should be "aspeed,ast2400-adc" or "aspeed,ast2500-adc"
> +- compatible: Should be "aspeed,ast2400-adc" or "aspeed,ast2500-adc" or "aspeed,ast2600-adc"
>  - reg: memory window mapping address and length
>  - clocks: Input clock used to derive the sample clock. Expected to be the
>            SoC's APB clock.
> @@ -20,3 +23,14 @@ Example:
>  		resets = <&syscon ASPEED_RESET_ADC>;
>  		#io-channel-cells = <1>;
>  	};
> +
> +Board level dts:
> +Required properties:
> +- ref_voltage: (ast2600 only)
> +	- Reference voltage in millivolts for the conversions.
> +	- The range of value is 900 to 2700 mv.

See above for suggestion on on this. For the internal case, will need
a name that expresses both what it is and what the units are.

int_ref_voltage_mv perhaps?

Yaml binding should check that either we have a regulator, or
we have this element.  That way we'll ensure we don't have any confusion
over which one to use.

Thanks,

Jonathan

> +
> +Example:
> +&adc0 {
> +	ref_voltage = <2500>;
> +};
> \ No newline at end of file

