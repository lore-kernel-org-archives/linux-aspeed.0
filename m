From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Wed, 10 Apr 2024 22:43:57 +0200
Subject: [PATCH v2 2/4] dt-bindings: rtc: lpc32xx-rtc: convert to dtschema
In-Reply-To: <20240410-rtc_dtschema-v2-2-d32a11ab0745@gmail.com>
References: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
 <20240410-rtc_dtschema-v2-2-d32a11ab0745@gmail.com>
Message-ID: <202404102043571b7450b5@mail.local>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/04/2024 17:55:34+0200, Javier Carrasco wrote:
> Convert existing binding to dtschema to support validation.
> 
> Add the undocumented 'clocks' property.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 --------
>  .../devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml   | 41 ++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt b/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
> deleted file mode 100644
> index a87a1e9bc060..000000000000
> --- a/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -* NXP LPC32xx SoC Real Time Clock controller
> -
> -Required properties:
> -- compatible: must be "nxp,lpc3220-rtc"
> -- reg: physical base address of the controller and length of memory mapped
> -  region.
> -- interrupts: The RTC interrupt
> -
> -Example:
> -
> -	rtc at 40024000 {
> -		compatible = "nxp,lpc3220-rtc";
> -		reg = <0x40024000 0x1000>;
> -		interrupts = <52 0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml b/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml
> new file mode 100644
> index 000000000000..62ddeef961e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/nxp,lpc32xx-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP LPC32xx SoC Real Time Clock
> +
> +maintainers:
> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    const: nxp,lpc3220-rtc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1

As I explained the clock doesn't really exist, there is no control over
it, it is a fixed 32768 Hz crystal, there is no point in describing it
as this is already the input clock of the SoC.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
