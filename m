From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Tue, 28 Sep 2021 02:50:59 +0000
Subject: [PATCH 10/10] dt-bindings: mmc: aspeed: Add a new compatible
 string
In-Reply-To: <YVIUf7/4ukMcrOb9@robh.at.kernel.org>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-11-chin-ting_kuo@aspeedtech.com>
 <YVIUf7/4ukMcrOb9@robh.at.kernel.org>
Message-ID: <HK0PR06MB2786DAAA2D6E58EA2E2FCB6BB2A89@HK0PR06MB2786.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, September 28, 2021 2:59 AM
> To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Subject: Re: [PATCH 10/10] dt-bindings: mmc: aspeed: Add a new compatible
> string
> 
> On Wed, Sep 22, 2021 at 06:31:16PM +0800, Chin-Ting Kuo wrote:
> > Add "aspeed,ast2600-emmc" compatible string for the sake of
> > distinguishing between SD and eMMC device.
> 
> Why?
> 
> Is the h/w block different? We already have properties to handle some of the
> eMMC specifics. Also, you can have a child node for the eMMC device if you
> need that.

There are two SD/SDIO controllers in a AST2600 SoC.
One is for SD card and the other is for eMMC.
Although both of them are embedded in the same SoC, the design of delay cell and
the manufacture process are different. The delay phase is definitely different and, thus,
we need a flag, compatible, to distinguish the device, SD or eMMC.

Without "aspeed,ast2600-emmc" compatible, of course, eMMC device can work with original
sdhci driver and device tree setting. But, for ultra-speed or HS200 case, AST2600 SoC needs some
phase delay which (maximum) value is different between SD and eMMC device.

> 
> >
> > Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > index 5bb66849df65..41105cd104c6 100644
> > --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > @@ -52,6 +52,7 @@ patternProperties:
> >            - aspeed,ast2400-sdhci
> >            - aspeed,ast2500-sdhci
> >            - aspeed,ast2600-sdhci
> > +          - aspeed,ast2600-emmc
> >        reg:
> >          maxItems: 1
> >          description: The SDHCI registers
> > --
> > 2.17.1
> >
> >
