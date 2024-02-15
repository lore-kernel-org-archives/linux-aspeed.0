From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Thu, 15 Feb 2024 01:56:00 +0000
Subject: =?utf-8?B?UkU6IOWbnuimhjogW1BBVENIXSBBZGQgZVNQSSBkZXZpY2UgZHJpdmVyIChm?=
 =?utf-8?Q?lash_channel)?=
In-Reply-To: <20240214-yoyo-platinum-dcd0e7e16a22@spud>
References: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
 <KL1PR06MB665234A65DB334B3BDF6AFA6914E2@KL1PR06MB6652.apcprd06.prod.outlook.com>
 <20240214-yoyo-platinum-dcd0e7e16a22@spud>
Message-ID: <TYZPR06MB6640F82C539F0B17BCDCC55E914D2@TYZPR06MB6640.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> 
> On Wed, Feb 14, 2024 at 11:34:31AM +0000, ChiaWei Wang wrote:
> > We appreciate that you are willing to help on the open source contribution.
> > However, please co-work with Aspeed before submitting drivers of Aspeed
> HW.
> > Otherwise, a misleading driver on the community are going to bring tons of
> customer issues to Aspeed.
> 
> It may not apply in this particular case as Aspeed did write the original driver
> and it is polite to work with previous authors when respinning a patchset, but in
> general there is no need to work with a hardware vendor before writing drivers
> for their hardware.
> 
> Blocking a driver because that company might receive more support requests
> is not the kernel's problem.

I agree with that and Aspeed will not refuse to support.

However, in this case, the authors, IBM, and Aspeed already have discussion (at least 4 times) before and foresee "issues" on practical eSPI SAFS use.
If there is already a known issue of the driver, why ignoring the previous discussion and push it?
A compromise is to ask for driver renaming to espi-mafs to avoid confusion.
Otherwise we need to explain, again, why the driver does not fulfill the SAFS expectation.

Regards,
Chiawei

