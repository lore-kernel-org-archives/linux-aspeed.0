From: Rob Herring <robh@kernel.org>
Date: Wed, 09 Aug 2023 22:19:40 -0600
Subject: [PATCH v8 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite
 4 board
In-Reply-To: <20230810034421.742166-2-Delphine_CC_Chiu@wiwynn.com>
References: <20230810034421.742166-1-Delphine_CC_Chiu@wiwynn.com>
 <20230810034421.742166-2-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <169164117998.3618854.8025888421725054954.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Thu, 10 Aug 2023 11:44:18 +0800, Delphine CC Chiu wrote:
> Document the new compatibles used on Facebook Yosemite 4.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changelog:
> v7 - Revise changelog format
> v6 - Change project name from yosemitev4 to yosemite4
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810034421.742166-2-Delphine_CC_Chiu at wiwynn.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

