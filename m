From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 1 Sep 2021 07:09:46 +0000
Subject: [PATCH 0/2] arm: aspeed: Add LPC uart routing support
In-Reply-To: <CACPK8XfeU0+w03fgYxXVMVYOW-2woXQtUZ4FEDri3MSe+80_Wg@mail.gmail.com>
References: <20210901062216.32675-1-chiawei_wang@aspeedtech.com>
 <CACPK8XfeU0+w03fgYxXVMVYOW-2woXQtUZ4FEDri3MSe+80_Wg@mail.gmail.com>
Message-ID: <KL1PR0601MB37810C5AB662895C0C716C8391CD9@KL1PR0601MB3781.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

> From: Joel Stanley <joel@jms.id.au>
> Sent: Wednesday, September 1, 2021 3:04 PM
> 
> On Wed, 1 Sept 2021 at 06:22, Chia-Wei Wang
> <chiawei_wang@aspeedtech.com> wrote:
> >
> > Add LPC uart routing driver and the device tree nodes.
> 
> Thanks for submitting this driver. There are many parties who are interested in
> this, so hopefully they can step forward and review.
> 
> Is this LPC UART routing, or UART routing in general? I know the register to
> control the routing is hidden in the LPC space, but I thought it was just general
> routing. I would drop the LPC part of the name.
> 
> You also need to update the bindings document with the new compatible string.
> Send a patch for Documentation/devicetree/bindings/mfd/aspeed-lpc.txt.

Thanks for the feedback.

The UART routing is general.
I will send a v2 patch which drops the LPC part of name.
And the compatible string will also be updated to the dt-bindings.

Chiawei
