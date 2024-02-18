From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Sun, 18 Feb 2024 09:36:27 +0000
Subject: =?utf-8?B?UkU6IOWbnuimhjogW1BBVENIXSBBZGQgZVNQSSBkZXZpY2UgZHJpdmVyIChm?=
 =?utf-8?Q?lash_channel)?=
In-Reply-To: <20240215-probable-gimmick-83d5dcbc4729@spud>
References: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
 <KL1PR06MB665234A65DB334B3BDF6AFA6914E2@KL1PR06MB6652.apcprd06.prod.outlook.com>
 <20240214-yoyo-platinum-dcd0e7e16a22@spud>
 <TYZPR06MB6640F82C539F0B17BCDCC55E914D2@TYZPR06MB6640.apcprd06.prod.outlook.com>
 <20240215-probable-gimmick-83d5dcbc4729@spud>
Message-ID: <KL1PR06MB6652F1A2D8652B727D5F581A91522@KL1PR06MB6652.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Conor Dooley <conor@kernel.org>
> Sent: Friday, February 16, 2024 1:13 AM
> 
> On Thu, Feb 15, 2024 at 01:56:00AM +0000, ChiaWei Wang wrote:
> > >
> > > On Wed, Feb 14, 2024 at 11:34:31AM +0000, ChiaWei Wang wrote:
> > > > We appreciate that you are willing to help on the open source
> contribution.
> > > > However, please co-work with Aspeed before submitting drivers of
> > > > Aspeed
> > > HW.
> > > > Otherwise, a misleading driver on the community are going to bring
> > > > tons of
> > > customer issues to Aspeed.
> > >
> > > It may not apply in this particular case as Aspeed did write the
> > > original driver and it is polite to work with previous authors when
> > > respinning a patchset, but in general there is no need to work with
> > > a hardware vendor before writing drivers for their hardware.
> > >
> > > Blocking a driver because that company might receive more support
> > > requests is not the kernel's problem.
> >
> > I agree with that and Aspeed will not refuse to support.
> >
> > However, in this case, the authors, IBM, and Aspeed already have discussion
> (at least 4 times) before and foresee "issues" on practical eSPI SAFS use.
> > If there is already a known issue of the driver, why ignoring the previous
> discussion and push it?
> > A compromise is to ask for driver renaming to espi-mafs to avoid confusion.
> > Otherwise we need to explain, again, why the driver does not fulfill the SAFS
> expectation.
> 
> To be clear, in case you misunderstood, I was making a general point and not
> about this particular patchset.

Thanks for the clarification and I understand your point.

Most Aspeed-related drivers are from the Aspeed SDK.
And we keep revising the SDK based on our customers' feedback and issues reported.
We only wish that the version submitted to the community will not result in unnecessary misunderstanding and thus more customer issues.

Regards,
Chiawei
