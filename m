From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 15 Sep 2021 02:21:41 +0000
Subject: [PATCH v4 1/4] dt-bindings: mfd: aspeed-lpc: Convert to YAML
 schema
In-Reply-To: <CAL_JsqLr-fpgXPLU3XHy9T5hUNbf-mBqeh1Sads=tXWx3LkkhQ@mail.gmail.com>
References: <20210913060231.15619-1-chiawei_wang@aspeedtech.com>
 <20210913060231.15619-2-chiawei_wang@aspeedtech.com>
 <CAL_JsqLr-fpgXPLU3XHy9T5hUNbf-mBqeh1Sads=tXWx3LkkhQ@mail.gmail.com>
Message-ID: <HK0PR06MB3779D499AEACDAF9801D383B91DB9@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Rob Herring <robh+dt@kernel.org>
> Sent: Tuesday, September 14, 2021 8:28 PM
> 
> On Mon, Sep 13, 2021 at 1:02 AM Chia-Wei Wang
> <chiawei_wang@aspeedtech.com> wrote:
> >
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
> > diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > deleted file mode 100644
> > index 936aa108eab4..000000000000
> > --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > +++ /dev/null
> > @@ -1,157 +0,0 @@
> >
> > +patternProperties:
> > +  "^lpc-ctrl@[0-9a-f]+$":
> > +    type: object
> > +
> > +    description:
> > +      The LPC Host Interface Controller manages functions exposed to the
> host such as
> > +      LPC firmware hub cycles, configuration of the LPC-to-AHB mapping,
> UART management
> > +      and bus snoop configuration.
> > +
> > +    properties:
> > +      comptabile:
> 
> typo here. This is the source of your warnings.

Thanks! Sorry for making this typo.
Will keep in mind to check the spelling in the future.

A v5 patch will be sent to fix these warning.

Regards,
Chiawei
