From: Rob Herring <robh@kernel.org>
Date: Mon, 13 Feb 2023 09:09:41 -0600
Subject: [RFC PATCH] dt-bindings: Add AST2600 i3c controller binding
In-Reply-To: <5c047dd91390b9ee4cd8bca3ff107db37a7be4ac.1676273912.git.jk@codeconstruct.com.au>
References: <5c047dd91390b9ee4cd8bca3ff107db37a7be4ac.1676273912.git.jk@codeconstruct.com.au>
Message-ID: <167630051588.6318.13648503218765402981.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Mon, 13 Feb 2023 15:41:52 +0800, Jeremy Kerr wrote:
> This change adds a devicetree binding for the ast2600 i3c controller
> hardware. This is heavily based on the designware i3c hardware, plus a
> reset facility and two platform-specific properties:
> 
>  - sda-pullup-ohms: to specify the value of the configurable pullup
>    resistors on the SDA line
> 
>  - global-regs: to reference the (ast2600-specific) i3c global register
>    block, and the device index to use within it.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
> RFC: the example in this depends on some not-yet-accepted patches for
> the clock and reset linkages:
> 
>   https://lore.kernel.org/linux-devicetree/cover.1676267865.git.jk at codeconstruct.com.au/T/
> 
> I'm also keen to get some review on the pullup configuration too.
> 
> ---
>  .../bindings/i3c/aspeed,ast2600-i3c.yaml      | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.example.dts:30.31-32 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/5c047dd91390b9ee4cd8bca3ff107db37a7be4ac.1676273912.git.jk at codeconstruct.com.au

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

