From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date: Fri, 23 Jul 2021 15:51:41 +0100
Subject: [v2 2/8] dt-bindings: iio: adc: Binding ast2600 adc.
In-Reply-To: <20210723081621.29477-3-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
 <20210723081621.29477-3-billy_tsai@aspeedtech.com>
Message-ID: <20210723155141.000039ee@Huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 23 Jul 2021 16:16:15 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> This patch add more description about aspeed adc and add two property
> for ast2600:
> - vref: used to configure reference voltage.
> - battery-sensing: used to enable battery sensing mode for last channel.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Hi Billy,

A few comments inline.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/aspeed,adc.yaml          | 28 +++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
> index 23f3da1ffca3..a562a7fbc30c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
> @@ -10,14 +10,26 @@ maintainers:
>    - Joel Stanley <joel@jms.id.au>
>  
>  description:

I think you need a | after description if you want the formatting to be
maintained (otherwise it will undo the line breaks).

> -  This device is a 10-bit converter for 16 voltage channels.  All inputs are
> -  single ended.
> +  ? 10-bits resolution for 16 voltage channels.
> +  At ast2400/ast2500 the device has only one engine with 16 voltage channels.
> +  At ast2600 the device split into two individual engine and each contains 8 voltage channels.

Please wrap lines at 80 chars unless it badly hurts readability.
engines

> +  ? Channel scanning can be non-continuous.
> +  ? Programmable ADC clock frequency.
> +  ? Programmable upper and lower bound for each channels.

I would use threshold rather than bound.   A bound restricts the
value, and I think this is measuring it?

> +  ? Interrupt when larger or less than bounds for each channels.
> +  ? Support hysteresis for each channels.
> +  ? Buildin a compensating method.

Built-in 

> +  Additional feature at ast2600

of ast2600

> +  ? Internal or External reference voltage.
> +  ? Support 2 Internal reference voltage 1.2v or 2.5v.
> +  ? Integrate dividing circuit for battery sensing.
>  
>  properties:
>    compatible:
>      enum:
>        - aspeed,ast2400-adc
>        - aspeed,ast2500-adc
> +      - aspeed,ast2600-adc
>  
>    reg:
>      maxItems: 1
> @@ -33,6 +45,18 @@ properties:
>    "#io-channel-cells":
>      const: 1
>  
> +  vref:
> +    minItems: 900
> +    maxItems: 2700
> +    default: 2500
> +    description:
> +      ADC Reference voltage in millivolts.

I'm not clear from this description.  Is this describing an externally
connected voltage reference?  If so it needs to be done as a regulator.
If it's a classic high precision reference, the dts can just use
a fixed regulator.

> +
> +  battery-sensing:
> +    type: boolean
> +    description:
> +      Inform the driver that last channel will be used to sensor battery.

This isn't (I think?) a standard dt binding, so it needs a manufacturer
prefix.

aspeed,battery-sensing

> +
>  required:
>    - compatible
>    - reg

