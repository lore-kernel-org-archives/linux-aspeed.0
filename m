From: Rob Herring <robh@kernel.org>
Date: Mon, 16 Aug 2021 15:07:03 -0500
Subject: [v3 01/15] dt-bindings: iio: adc: Add ast2600-adc bindings
In-Reply-To: <20210816104846.13155-2-billy_tsai@aspeedtech.com>
References: <20210816104846.13155-1-billy_tsai@aspeedtech.com>
 <20210816104846.13155-2-billy_tsai@aspeedtech.com>
Message-ID: <1629144423.392245.2563334.nullmailer@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 16 Aug 2021 18:48:32 +0800, Billy Tsai wrote:
> Add device tree bindings document for the aspeed ast2600 adc device
> driver.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/iio/adc/aspeed,ast2600-adc.yaml  | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml: properties:aspeed,int_vref_mv: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('enum' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml: properties:aspeed,int_vref_mv: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	1200 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	2500 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml: ignoring, error in schema: properties: aspeed,int_vref_mv
warning: no schema found in file: ./Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.example.dt.yaml:0:0: /example-0/adc at 1e6e9000: failed to match any schema with compatible: ['aspeed,ast2600-adc0']
Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.example.dt.yaml:0:0: /example-0/adc at 1e6e9100: failed to match any schema with compatible: ['aspeed,ast2600-adc1']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1517123

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

