From: Mark Brown <broonie@kernel.org>
Date: Tue, 17 May 2022 13:10:44 +0100
Subject: (subset) [PATCH v7 00/11] spi: spi-mem: Convert Aspeed SMC
 driver to spi-mem
In-Reply-To: <20220517110509.2e6xbwot63yl6a3c@ti.com>
References: <20220509175616.1089346-1-clg@kaod.org>
 <165272636363.750911.14933122170662994904.b4-ty@kernel.org>
 <20220517110509.2e6xbwot63yl6a3c@ti.com>
Message-ID: <YoOQxJV2xNfkkwQS@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 17, 2022 at 04:35:09PM +0530, Pratyush Yadav wrote:
> On 16/05/22 07:39PM, Mark Brown wrote:
> > On Mon, 9 May 2022 19:56:05 +0200, C?dric Le Goater wrote:

> > [08/11] spi: aspeed: Calibrate read timings
> >         commit: eeaec1ea05c0e0f08e04c6844f20cc24a2fcc0f4

> I have repeatedly objected to this patch [0][1][2] and you have 
> repeatedly decided to not address my objections. I won't spend any more 
> time fighting it. But I will say that you should not expect any 
> guarantees that SPI NOR or SPI NAND will not break your calibration in 
> the future if they decide to move the dirmap_create() call around.

You == Cedric here.  Sorry, I thought that had been addressed as there
hadn't been anything I'd noticed on the thread for a few versions.  It
does look like there was agreement that there was a problem too :/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220517/deb16e3a/attachment.sig>
