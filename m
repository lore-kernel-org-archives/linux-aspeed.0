From: Rob Herring <robh@kernel.org>
Date: Tue, 28 Sep 2021 17:28:27 -0500
Subject: [PATCH 10/10] dt-bindings: mmc: aspeed: Add a new compatible
 string
In-Reply-To: <HK0PR06MB2786DAAA2D6E58EA2E2FCB6BB2A89@HK0PR06MB2786.apcprd06.prod.outlook.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-11-chin-ting_kuo@aspeedtech.com>
 <YVIUf7/4ukMcrOb9@robh.at.kernel.org>
 <HK0PR06MB2786DAAA2D6E58EA2E2FCB6BB2A89@HK0PR06MB2786.apcprd06.prod.outlook.com>
Message-ID: <CAL_Jsq+TZFXrvfJTjofVcnT6jJat-3SvWj+jAq0QST8ndfeUMA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 27, 2021 at 9:51 PM Chin-Ting Kuo
<chin-ting_kuo@aspeedtech.com> wrote:
>
> Hi Rob,
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, September 28, 2021 2:59 AM
> > To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> > Subject: Re: [PATCH 10/10] dt-bindings: mmc: aspeed: Add a new compatible
> > string
> >
> > On Wed, Sep 22, 2021 at 06:31:16PM +0800, Chin-Ting Kuo wrote:
> > > Add "aspeed,ast2600-emmc" compatible string for the sake of
> > > distinguishing between SD and eMMC device.
> >
> > Why?
> >
> > Is the h/w block different? We already have properties to handle some of the
> > eMMC specifics. Also, you can have a child node for the eMMC device if you
> > need that.
>
> There are two SD/SDIO controllers in a AST2600 SoC.
> One is for SD card and the other is for eMMC.
> Although both of them are embedded in the same SoC, the design of delay cell and
> the manufacture process are different. The delay phase is definitely different and, thus,
> we need a flag, compatible, to distinguish the device, SD or eMMC.
>
> Without "aspeed,ast2600-emmc" compatible, of course, eMMC device can work with original
> sdhci driver and device tree setting. But, for ultra-speed or HS200 case, AST2600 SoC needs some
> phase delay which (maximum) value is different between SD and eMMC device.

This is quite common as tweaking the timing is also need per board.
Look at what other bindings have done. A property is more appropriate
here.

Rob
