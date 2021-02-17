From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 17 Feb 2021 08:04:17 +0000
Subject: [PATCH v5 1/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
In-Reply-To: <CACPK8XdFLKg9k6snLSZrRzorxBeg1fLoqakm6J_8VCXh_=JEQA@mail.gmail.com>
References: <20210114131622.8951-1-chiawei_wang@aspeedtech.com>
 <20210114131622.8951-2-chiawei_wang@aspeedtech.com>
 <85f00459-4a39-441e-8119-8e12f8132cfe@www.fastmail.com>
 <HK0PR06MB3779B25984A461E4A1ADEF1191869@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <CACPK8XdFLKg9k6snLSZrRzorxBeg1fLoqakm6J_8VCXh_=JEQA@mail.gmail.com>
Message-ID: <HK0PR06MB37793DD6817B097B7B085CF291869@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

Thanks for your feedback.
Really appreciate all your review effort.

Chiawei

> -----Original Message-----
> From: Joel Stanley <joel@jms.id.au>
> Sent: Wednesday, February 17, 2021 3:45 PM
> To: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> Subject: Re: [PATCH v5 1/5] dt-bindings: aspeed-lpc: Remove LPC partitioning
> 
> Hi Chaiwei,
> 
> On Wed, 17 Feb 2021 at 07:40, ChiaWei Wang
> <chiawei_wang@aspeedtech.com> wrote:
> >
> > Hi All,
> >
> > Do you have update on this patch series?
> > Aspeed has subsequent LPC module upstream plan.
> > We hope that the following patches can be on the basis of the fixed LPC
> layout.
> 
> Andrew has expressed his support for your changes. I will take time to closely
> review your proposal this week.
> 
> We will set the goal of having this rework merged for the next merge window.
> 
> Cheers,
> 
> Joel
> 
> 
> > Thanks.
> >
> > Chiawei
> >
> > > -----Original Message-----
> > > From: Andrew Jeffery <andrew@aj.id.au>
> > > Sent: Wednesday, January 27, 2021 8:25 AM
> > > To: Lee Jones <lee.jones@linaro.org>
> > > Subject: Re: [PATCH v5 1/5] dt-bindings: aspeed-lpc: Remove LPC
> > > partitioning
> > >
> > >
> > >
> > > On Thu, 14 Jan 2021, at 23:46, Chia-Wei, Wang wrote:
> > > > The LPC controller has no concept of the BMC and the Host partitions.
> > > > This patch fixes the documentation by removing the description on
> > > > LPC partitions. The register offsets illustrated in the DTS node
> > > > examples are also fixed to adapt to the LPC DTS change.
> > > >
> > > > Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> > >
> > > Any thoughts Lee? If you ack it would you be happy for the patch to
> > > go through the Aspeed tree?
> > >
> > > Andrew
