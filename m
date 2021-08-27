From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Fri, 27 Aug 2021 03:08:19 +0000
Subject: [PATCH v3 1/4] dt-bindings: aspeed: Add eSPI controller
In-Reply-To: <1629984361.334223.1033382.nullmailer@robh.at.kernel.org>
References: <20210826061623.6352-1-chiawei_wang@aspeedtech.com>
 <20210826061623.6352-2-chiawei_wang@aspeedtech.com>
 <1629984361.334223.1033382.nullmailer@robh.at.kernel.org>
Message-ID: <HK0PR06MB3779F7F75D24326E6F0DB23591C89@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, August 26, 2021 9:26 PM
> 
> On Thu, 26 Aug 2021 14:16:20 +0800, Chia-Wei Wang wrote:
> > Add dt-bindings for Aspeed eSPI controller
> >
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/soc/aspeed/espi.yaml  | 157
> > ++++++++++++++++++
> >  1 file changed, 157 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> >
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/as
> peed/espi.example.dt.yaml: espi at 1e6ee000: 'espi-ctrl at 0', 'espi-mmbi at 800'
> do not match any of the regexes: 'pinctrl-[0-9]+'
> 	From schema:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/as
> peed/espi.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1520968
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

The warning has been fixed by using patternProperties to define the espi-ctrl and the espi-mmbi child nodes.
The updated version will be submitted soon. Thanks.

Chiawei
