From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Tue, 8 Oct 2024 02:01:18 +0000
Subject: [PATCH v1 1/2] dt-bindings: interrupt-controller: Add support for
 ASPEED AST27XX INTC
In-Reply-To: <172354119091.52485.8216967911640529962.robh@kernel.org>
References: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
 <20240813074338.969883-2-kevin_chen@aspeedtech.com>
 <172354119091.52485.8216967911640529962.robh@kernel.org>
Message-ID: <PSAPR06MB4949621DE71075572B67EEE7897E2@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > The ASPEED AST27XX interrupt controller(INTC) combines 32 interrupts
> > sources into 1 interrupt into GIC from CPU die to CPU die.
> > The INTC design contains soc0_intc and soc1_intc module doing hand
> > shake between CPU die and IO die INTC.
> >
> > In soc0_intc11, each bit represent 1 GIC_SPI interrupt from soc1_intcX.
> > In soc1_intcX, each bit represent 1 device interrupt in IO die.
> >
> > By soc1_intcX in IO die, AST27XX INTC combines 32 interrupt sources to
> > 1 interrupt source in soc0_intc11 in CPU die, which achieve the
> > interrupt passing between the different die in AST27XX.
> > ---
> >  .../aspeed,ast2700-intc.yaml                  | 120
> ++++++++++++++++++
> >  1 file changed, 120 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-
> > intc.yaml
> >
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc
> .yaml:24:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc
> .yaml:25:11: [warning] wrong indentation: expected 12 but found 10
> (indentation)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/inte
> rrupt-controller/aspeed,ast2700-intc.yaml: 'example' is not one of ['$id',
> '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf',
> 'definitions', '$defs', 'additionalProperties', 'dependencies',
> 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties',
> 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers',
> 'select', '$ref']
> 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202408130743
> 38.969883-2-kevin_chen at aspeedtech.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above error(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
Agree.

> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
Agree.

I will fix all the warnings in ' make dt_binding_check '.

Thanks a lot.
