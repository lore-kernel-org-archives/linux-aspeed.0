From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Tue, 28 Sep 2021 02:50:39 +0000
Subject: [PATCH 09/10] dt-bindings: mmc: aspeed: Add max-tap-delay property
In-Reply-To: <YVIQNPbbnhIqTSuu@robh.at.kernel.org>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-10-chin-ting_kuo@aspeedtech.com>
 <YVIQNPbbnhIqTSuu@robh.at.kernel.org>
Message-ID: <HK0PR06MB2786A27B0A4C7D1D10415E90B2A89@HK0PR06MB2786.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

Thanks for your review.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, September 28, 2021 2:41 AM
> To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Subject: Re: [PATCH 09/10] dt-bindings: mmc: aspeed: Add max-tap-delay
> property
> 
> On Wed, Sep 22, 2021 at 06:31:15PM +0800, Chin-Ting Kuo wrote:
> > Add max-tap-delay proptery in order to record the maximum tap delay on
> > different platforms.
> >
> > Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > index 987b287f3bff..5bb66849df65 100644
> > --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > @@ -37,6 +37,9 @@ properties:
> >    clocks:
> >      maxItems: 1
> >      description: The SD/SDIO controller clock gate
> > +  max-tap-delay:
> > +    maxItems: 1
> 
> An array?

No, it is an "int" value and this will be fixed in the next patch version.

> > +    description: The maximum delay in picosecond for SD/SDIO
> > + controller
> 
> Properties with a unit should have a standard unit suffix.
> 
> Should be common property? If not, needs a vendor prefix.

Okay, a vender prefix and an unit suffix will be add in the next patch version.

> 
> >
> >  patternProperties:
> >    "^sdhci@[0-9a-f]+$":
> > --
> > 2.17.1
> >
> >
