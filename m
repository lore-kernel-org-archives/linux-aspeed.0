From: Jamin Lin <jamin_lin@aspeedtech.com>
Date: Thu, 20 May 2021 11:16:08 +0800
Subject: [PATCH 3/3] dt-bindings: aspeed-i2c: Convert txt to yaml format
In-Reply-To: <1621438164.132520.3134233.nullmailer@robh.at.kernel.org>
References: <20210519080436.18975-1-jamin_lin@aspeedtech.com>
 <20210519080436.18975-4-jamin_lin@aspeedtech.com>
 <1621438164.132520.3134233.nullmailer@robh.at.kernel.org>
Message-ID: <20210520031608.GA3601@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 05/19/2021 15:29, Rob Herring wrote:
> On Wed, 19 May 2021 16:04:29 +0800, Jamin Lin wrote:
> > Add global-reg node for AST2600. Document the properties for
> > "aspeed,ast2600-i2c-global" compatible node.
> > 
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/i2c/aspeed,i2c.yaml   | 89 +++++++++++++++++++
> >  .../devicetree/bindings/i2c/i2c-aspeed.txt    | 49 ----------
> >  2 files changed, 89 insertions(+), 49 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/i2c/aspeed,i2c.example.dt.yaml:0:0: /example-0/i2c-global-regs at 0: failed to match any schema with compatible: ['aspeed,ast2600-i2c-global', 'syscon']
> 
> See https://patchwork.ozlabs.org/patch/1480769
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
>
Thanks for your review.
yes, I did not add "DT_CHECKER_FLAGS" to check my patch.
I will re-sent this patch.
Thanks
