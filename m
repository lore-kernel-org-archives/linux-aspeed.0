From: Rob Herring (Arm) <robh@kernel.org>
Date: Fri, 02 Aug 2024 04:29:15 -0600
Subject: [PATCH v2 1/9] dt-bindings: mfd: aspeed,ast2x00-scu: Add
 ASPEED AST2700-SCUX schema
In-Reply-To: <20240802090544.2741206-3-kevin_chen@aspeedtech.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
 <20240802090544.2741206-3-kevin_chen@aspeedtech.com>
Message-ID: <172259455507.2558656.18344933444213909682.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Fri, 02 Aug 2024 17:05:36 +0800, Kevin Chen wrote:
> Add compatible for two SCU of SCU0 and SCU1 in AST2700.
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> ---
>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      | 70 +++++++++++++------
>  1 file changed, 50 insertions(+), 20 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml: 'scu at ast2xx00-scu' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml: 'scu at ast2xx00-scux' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml: scu at ast2xx00-scu: Missing additionalProperties/unevaluatedProperties constraint
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml: scu at ast2xx00-scux: Missing additionalProperties/unevaluatedProperties constraint

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240802090544.2741206-3-kevin_chen at aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

