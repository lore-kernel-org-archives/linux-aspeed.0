From: Rob Herring <robh@kernel.org>
Date: Thu, 25 Apr 2024 18:40:00 -0500
Subject: [PATCH v3 06/14] dt-bindings: fsi: Document the FSI controller
 common properties
In-Reply-To: <20240425213701.655540-7-eajames@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-7-eajames@linux.ibm.com>
Message-ID: <171408839666.3902693.1860621022882259895.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Thu, 25 Apr 2024 16:36:53 -0500, Eddie James wrote:
> Since there are multiple FSI controllers documented, the common
> properties should be documented separately and then referenced
> from the specific controller documentation.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../bindings/fsi/fsi-controller.yaml          | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-controller.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/fsi/fsi-controller.example.dtb: /example-0/fsi at 3400: failed to match any schema with compatible: ['fsi-controller']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240425213701.655540-7-eajames at linux.ibm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

