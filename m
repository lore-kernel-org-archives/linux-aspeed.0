From: Rob Herring <robh@kernel.org>
Date: Wed, 24 Jan 2024 01:39:45 -0600
Subject: [PATCH v13 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
In-Reply-To: <20240124060705.1342461-3-billy_tsai@aspeedtech.com>
References: <20240124060705.1342461-1-billy_tsai@aspeedtech.com>
 <20240124060705.1342461-3-billy_tsai@aspeedtech.com>
Message-ID: <170608198415.3412038.3874422575074669118.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Wed, 24 Jan 2024 14:07:04 +0800, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-pwm-tach device, which can
> support up to 16 PWM outputs and 16 fan tach input.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.example.dtb: pwm-tach-controller at 1e610000: fan-0: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.example.dtb: pwm-tach-controller at 1e610000: fan-1: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/aspeed,g6-pwm-tach.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.example.dtb: fan-0: 'tach-ch' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/hwmon/pwm-fan.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.example.dtb: fan-1: 'tach-ch' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/hwmon/pwm-fan.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240124060705.1342461-3-billy_tsai at aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

