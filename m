From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Jul 2018 16:30:46 -0600
Subject: [PATCH 11/14] dt-bindings: fsi: Document binding for the
 fsi-master-ast-cf "device"
In-Reply-To: <20180626232605.13420-12-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-12-benh@kernel.crashing.org>
Message-ID: <20180703223046.GA20184@rob-hp-laptop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jun 27, 2018 at 09:26:02AM +1000, Benjamin Herrenschmidt wrote:
> This isn't per-se a real device, it's a pseudo-device that
> represents the use of the Aspeed built-in ColdFire to
> implement the FSI protocol by bitbanging the GPIOs instead
> of doing it from the ARM core.
> 
> Thus it's a drop-in replacement for the existing
> fsi-master-gpio pseudo-device for use on systems for which
> a corresponding firmware file exists. It has most of the
> same properties, plus some more needed to operate the
> coprocessor.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  .../bindings/fsi/fsi-master-ast-cf.txt        | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> 
> diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> new file mode 100644
> index 000000000000..50913ae685cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> @@ -0,0 +1,36 @@
> +Device-tree bindings for ColdFire offloaded gpio-based FSI master driver
> +------------------------------------------------------------------------
> +
> +Required properties:
> + - compatible =
> +   	      "fsi-master-ast-2400-cf" for an AST2400 based system
> +	    or
> +	      "fsi-master-ast-2500-cf" for an AST2500 based system

<vendor>,<soc>-<block>

> +
> + - clock-gpios = <gpio-descriptor>;	: GPIO for FSI clock
> + - data-gpios = <gpio-descriptor>;	: GPIO for FSI data signal
> + - enable-gpios = <gpio-descriptor>;	: GPIO for enable signal
> + - trans-gpios = <gpio-descriptor>;	: GPIO for voltage translator enable
> + - mux-gpios = <gpio-descriptor>;	: GPIO for pin multiplexing with other

So the gpio info is pased to the CF? Otherwise, what's the point of 
having these in DT?

> +                                          functions (eg, external FSI masters)
> + - memory-region = <phandle>;		: Reference to the reserved memory for
> +                                          the ColdFire. Must be 2M aligned on
> +					  AST2400 and 1M aligned on AST2500

> + - sram = <phandle>;			: Reference to the SRAM node.
> + - cvic = <phandle>;			: Reference to the CVIC node.

Vendor prefixes.

> + - fw-name = <string>;			: The name used to construct the firmware
> +   	     				  file name (cf-fsi-<name>.bin)

firmware-name is used in some other places (and is the full filename).

> + - fw-platform-sig = <value>;		: A signature value that must match the one
> +   		     			  contained in the firmware image. Known
> +					  values are listed in the firmware interface
> +					  file cf-fsi-fw.h

Vendor prefix unless you think this could be common.

> +Examples:
> +
> +    fsi-master {
> +        compatible = "fsi-master-gpio", "fsi-master";

Forget to update the example?

> +        clock-gpios = <&gpio 0>;
> +        data-gpios = <&gpio 1>;
> +        enable-gpios = <&gpio 2>;
> +        trans-gpios = <&gpio 3>;
> +        mux-gpios = <&gpio 4>;
> +    }
> -- 
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
