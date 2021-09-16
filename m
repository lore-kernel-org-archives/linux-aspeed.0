From: Rob Herring <robh@kernel.org>
Date: Thu, 16 Sep 2021 07:21:53 -0500
Subject: [PATCH v5 1/4] dt-bindings: mfd: aspeed-lpc: Convert to YAML
 schema
In-Reply-To: <20210916092515.10553-2-chiawei_wang@aspeedtech.com>
References: <20210916092515.10553-1-chiawei_wang@aspeedtech.com>
 <20210916092515.10553-2-chiawei_wang@aspeedtech.com>
Message-ID: <1631794913.526068.1119423.nullmailer@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 16 Sep 2021 17:25:12 +0800, Chia-Wei Wang wrote:
> Convert the bindings of Aspeed LPC from text file into YAML schema.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 157 ---------------
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 187 ++++++++++++++++++
>  2 files changed, 187 insertions(+), 157 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dt.yaml:0:0: /example-0/lpc at 1e789000/lpc-snoop at 90: failed to match any schema with compatible: ['aspeed,ast2600-lpc-snoop']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1528736

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

