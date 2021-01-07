From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Thu, 7 Jan 2021 02:31:16 +0000
Subject: [PATCH 1/6] dt-bindings: aspeed: Add eSPI controller
In-Reply-To: <1609945675.315536.2229518.nullmailer@robh.at.kernel.org>
References: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
 <20210106055939.19386-2-chiawei_wang@aspeedtech.com>
 <1609945675.315536.2229518.nullmailer@robh.at.kernel.org>
Message-ID: <HK0PR06MB37793C49F562E169393AB0A491AF0@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, January 6, 2021 11:08 PM
> To: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> Subject: Re: [PATCH 1/6] dt-bindings: aspeed: Add eSPI controller
> 
> On Wed, 06 Jan 2021 13:59:34 +0800, Chia-Wei, Wang wrote:
> > Add dt-bindings and the inclusion header for Aspeed eSPI controller.
> >
> > Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/soc/aspeed/espi.yaml  | 252
> ++++++++++++++++++
> >  .../interrupt-controller/aspeed-espi-ic.h     |  15 ++
> >  2 files changed, 267 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> >  create mode 100644
> > include/dt-bindings/interrupt-controller/aspeed-espi-ic.h
> >
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error:
> Documentation/devicetree/bindings/soc/aspeed/espi.example.dts:45.35-36
> syntax error FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:344:
> Documentation/devicetree/bindings/soc/aspeed/espi.example.dt.yaml] Error 1
> make: *** [Makefile:1370: dt_binding_check] Error 2
> 
> See https://patchwork.ozlabs.org/patch/1422809
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

My 'make dt_binding_check' did not show the error.
I will update the tool as suggested to fix the error. Thanks.

