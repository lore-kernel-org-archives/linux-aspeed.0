From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 26 Feb 2024 08:08:42 +0100
Subject: [PATCH v3] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT
 schema
In-Reply-To: <20240226051645.414935-1-andrew@codeconstruct.com.au>
References: <20240226051645.414935-1-andrew@codeconstruct.com.au>
Message-ID: <458becdb-fb1e-4808-87b6-3037ec945647@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26/02/2024 06:16, Andrew Jeffery wrote:
> Squash warnings such as:
> 
> ```
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb at 1e600000/gpio at 1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
> ```
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

...

> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: The clock to use for debounce timings
> +
> +  gpio-controller: true
> +  gpio-line-names: true

min/maxItems

> +  gpio-ranges: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  ngpios: true

Where are the constraints I asked? minimum, maximum.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - gpio-controller
> +  - "#gpio-cells"
> +


Best regards,
Krzysztof

