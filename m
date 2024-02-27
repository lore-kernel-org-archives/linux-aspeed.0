From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 27 Feb 2024 14:16:52 +1030
Subject: [PATCH v4] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to
 DT schema
In-Reply-To: <20240227034047.GA2644802-robh@kernel.org>
References: <20240227004414.841391-1-andrew@codeconstruct.com.au>
	 <170900020204.2360855.790404478830111761.robh@kernel.org>
	 <20240227034047.GA2644802-robh@kernel.org>
Message-ID: <b69298f73d4d51546402410b45963f137d3e3c98.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-02-26 at 21:40 -0600, Rob Herring wrote:
> On Mon, Feb 26, 2024 at 08:16:43PM -0600, Rob Herring wrote:
> > 
> > On Tue, 27 Feb 2024 11:14:14 +1030, Andrew Jeffery wrote:
> > > Squash warnings such as:
> > > 
> > > ```
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb at 1e600000/gpio at 1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
> > > ```
> > > 
> > > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > > ---
> > > v4: Add constraints for gpio-line-names, ngpios as requested by Krzysztof:
> > >     https://lore.kernel.org/all/458becdb-fb1e-4808-87b6-3037ec945647 at linaro.org/
> > > 
> > >     Add more examples to exercise constraints.
> > > 
> > > v3: https://lore.kernel.org/all/20240226051645.414935-1-andrew at codeconstruct.com.au/
> > > 
> > >     Base on v6.8-rc6, fix yamllint warning
> > > 
> > >     Rob's bot picked the missing `#interrupt-cells` in the example on v2[1]. The
> > >     patch was based on v6.8-rc1, and going back over my shell history I missed
> > >     the following output from `make dt_binding_check`:
> > > 
> > >     ```
> > >     ...
> > >       LINT    Documentation/devicetree/bindings
> > >       usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [-f {parsable,standard,colored,github,auto}] [-s] [--no-warnings] [-v] [FILE_OR_DIR ...]
> > >       yamllint: error: one of the arguments FILE_OR_DIR - is required
> > >     ...
> > >     ```
> > > 
> > >     I've rebased on v6.8-rc6 and no-longer see the issue with the invocation
> > >     of `yamllint`.
> > > 
> > > [1]: https://lore.kernel.org/all/170892197611.2260479.15343562563553959436.robh at kernel.org/
> > > 
> > > v2: https://lore.kernel.org/all/20240226031951.284847-1-andrew at codeconstruct.com.au/
> > > 
> > >     Address feedback from Krzysztof:
> > >     https://lore.kernel.org/all/0d1dd262-b6dd-4d71-9239-8b0aec8cceff at linaro.org/
> > > 
> > > v1: https://lore.kernel.org/all/20240220052918.742793-1-andrew at codeconstruct.com.au/
> > > 
> > >  .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 149 ++++++++++++++++++
> > >  .../devicetree/bindings/gpio/gpio-aspeed.txt  |  39 -----
> > >  2 files changed, 149 insertions(+), 39 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > In file included from Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.example.dts:91:
> > ./scripts/dtc/include-prefixes/dt-bindings/clock/ast2600-clock.h:14: warning: "ASPEED_CLK_GATE_LCLK" redefined
> >    14 | #define ASPEED_CLK_GATE_LCLK            6
> 
> The examples aren't isolated from each other, so you can't have 
> conflicting includes. You'll have to drop some of the examples or drop 
> their use of the conflicting include.

Thanks. I've reworked the patch to avoid use of the conflicting
includes. I'm also sorting myself out to avoid repeating the process
flaw of failing to run `make dt_binding_check` on the patch I ended up
sending.

Andrew

