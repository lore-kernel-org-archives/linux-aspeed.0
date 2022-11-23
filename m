From: Rob Herring <robh@kernel.org>
Date: Wed, 23 Nov 2022 09:07:21 -0600
Subject: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
In-Reply-To: <20221123061635.32025-2-billy_tsai@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
Message-ID: <166921592541.2001852.8427859391374590200.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Wed, 23 Nov 2022 14:16:31 +0800, Billy Tsai wrote:
> Add device binding for aspeed pwm-tach device which is a multi-function
> device include pwm and tach function.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/pwm/aspeed,ast2600-pwm.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb: pwm-tach at 1e610000: pwm: False schema does not allow {'compatible': ['aspeed,ast2600-pwm'], '#pwm-cells': [[3]], 'pinctrl-names': ['default'], 'pinctrl-0': [[4294967295]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb: pwm-tach at 1e610000: tach: False schema does not allow {'compatible': ['aspeed,ast2600-tach'], 'pinctrl-names': ['default'], 'pinctrl-0': [[4294967295]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb:0:0: /example-0/pwm-tach at 1e610000/pwm: failed to match any schema with compatible: ['aspeed,ast2600-pwm']
Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.example.dtb:0:0: /example-0/pwm-tach at 1e610000/tach: failed to match any schema with compatible: ['aspeed,ast2600-tach']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221123061635.32025-2-billy_tsai at aspeedtech.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

