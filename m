From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Fri, 10 Sep 2021 01:38:45 +0000
Subject: [PATCH v3 1/3] dt-bindings: aspeed: Add UART routing controller
In-Reply-To: <1631190773.304300.200343.nullmailer@robh.at.kernel.org>
References: <20210909102907.32037-1-chiawei_wang@aspeedtech.com>
 <20210909102907.32037-2-chiawei_wang@aspeedtech.com>
 <1631190773.304300.200343.nullmailer@robh.at.kernel.org>
Message-ID: <HK0PR06MB3779990AF1A5BF5300DC9B0E91D69@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, September 9, 2021 8:33 PM
> 
> On Thu, 09 Sep 2021 18:29:05 +0800, Chia-Wei Wang wrote:
> > Add dt-bindings for Aspeed UART routing controller.
> >
> > Signed-off-by: Oskar Senft <osk@google.com>
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  .../bindings/soc/aspeed/uart-routing.yaml     | 70
> +++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
> >
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/soc/aspeed/uart-routing.example.dt.yaml:
> 0:0: /example-0/lpc at 1e789000: failed to match any schema with compatible:
> ['aspeed,ast2600-lpc-v2', 'simple-mfd', 'syscon']

The "aspeed,ast2600-lpc-v2" compatible string is described in the .txt file 'aspeed-lpc.txt'.
Do we have to firstly convert the text file into YAML one to resolve this dependency issue?

Regards,
Chiawei

> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1526149
> 
> This check can fail if there are any dependencies. The base for a patch series is
> generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above error(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

