From: Rob Herring <robh@kernel.org>
Date: Mon, 06 Feb 2023 13:49:44 -0600
Subject: [PATCH] dt-bindings : misc : aspeed,cvic interrupt controller
 : convert the binding document to yaml
In-Reply-To: <20230206153325.43692-1-sunrockers8@gmail.com>
References: <20230206153325.43692-1-sunrockers8@gmail.com>
Message-ID: <167571291763.1202238.8557252319537323407.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Mon, 06 Feb 2023 21:03:09 +0530, Vijaya Anand wrote:
>     Convert the binding document for ASPEED AST2400 and AST2500 coprocessor interrupt controller
>     from txt to yaml so one could validate dt-entries correctly and any future additions can go
>     into yaml format. The options for compatability described according to the example given.
> ---
>  .../devicetree/bindings/misc/aspeed,cvic.txt  | 35 ----------
>  .../devicetree/bindings/misc/aspeed,cvic.yaml | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/misc/aspeed,cvic.yaml:23:111: [warning] line too long (123 > 110 characters) (line-length)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230206153325.43692-1-sunrockers8 at gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

