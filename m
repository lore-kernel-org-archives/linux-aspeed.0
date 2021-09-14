From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Tue, 14 Sep 2021 01:33:54 +0000
Subject: [PATCH v4 1/4] dt-bindings: mfd: aspeed-lpc: Convert to YAML
 schema
In-Reply-To: <1631535523.196891.444718.nullmailer@robh.at.kernel.org>
References: <20210913060231.15619-1-chiawei_wang@aspeedtech.com>
 <20210913060231.15619-2-chiawei_wang@aspeedtech.com>
 <1631535523.196891.444718.nullmailer@robh.at.kernel.org>
Message-ID: <HK0PR06MB377931A31F7A51B443AC3B3291DA9@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Rob Herring <robh@kernel.org>
> Sent: Monday, September 13, 2021 8:19 PM
> 
> On Mon, 13 Sep 2021 14:02:28 +0800, Chia-Wei Wang wrote:
> > Convert the bindings of Aspeed LPC from text file into YAML schema.
> >
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 157 ---------------
> >  .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 187
> ++++++++++++++++++
> >  2 files changed, 187 insertions(+), 157 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> >
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dts:30.35-36.15:
> Warning (unique_unit_address): /example-0/lpc at 1e789000/lpc-ctrl at 80:
> duplicate unit-address (also used in node
> /example-0/lpc at 1e789000/lpc-snoop at 80)
> Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dt.yaml:0:0:
> /example-0/lpc at 1e789000/lpc-ctrl at 80: failed to match any schema with
> compatible: ['aspeed,ast2600-lpc-ctrl']
> Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dt.yaml:0:0:
> /example-0/lpc at 1e789000/reset-controller at 98: failed to match any schema
> with compatible: ['aspeed,ast2600-lpc-reset']
> Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dt.yaml:0:0:
> /example-0/lpc at 1e789000/lpc-snoop at 80: failed to match any schema with
> compatible: ['aspeed,ast2600-lpc-snoop']
> 

I also encountered this error locally.
However, I couldn't find the root cause as these three compatible strings have been described in the same YAML file.
Could you guys help to give me some hints to resolve this issue? Greatly appreciate that.

> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1527193
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

My dtschema & yamllint version:
dtschema-2021.7
yamllint-1.26.3

Regards,
Chiawei
