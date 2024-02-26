From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 27 Feb 2024 09:12:10 +1030
Subject: [PATCH v3] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to
 DT schema
In-Reply-To: <458becdb-fb1e-4808-87b6-3037ec945647@linaro.org>
References: <20240226051645.414935-1-andrew@codeconstruct.com.au>
	 <458becdb-fb1e-4808-87b6-3037ec945647@linaro.org>
Message-ID: <cd7806bf4ae8818697b1eba47b380c82a919ecc5.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-02-26 at 08:08 +0100, Krzysztof Kozlowski wrote:
> On 26/02/2024 06:16, Andrew Jeffery wrote:
> > Squash warnings such as:
> > 
> > ```
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb at 1e600000/gpio at 1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
> > ```
> > 
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> 
> ...
> 
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description: The clock to use for debounce timings
> > +
> > +  gpio-controller: true
> > +  gpio-line-names: true
> 
> min/maxItems

Ack.

> 
> > +  gpio-ranges: true
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 2
> > +
> > +  ngpios: true
> 
> Where are the constraints I asked? minimum, maximum.

Sorry. Thanks for clarifying. I'll address that in v4.

Andrew

