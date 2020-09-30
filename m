From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 30 Sep 2020 07:54:30 +0000
Subject: [PATCH 0/4] Remove LPC register partitioning
In-Reply-To: <485ec282-568f-458c-a91e-14c89415b8e5@www.fastmail.com>
References: <20200911034631.8473-1-chiawei_wang@aspeedtech.com>
 <CACPK8XcYvUj3W-CPzXKugp3wx7rcLEJ_8f2-Bi6V7QHZpopBbA@mail.gmail.com>
 <551926fc-7bd4-4a0e-8fcf-4675dcdba22b@www.fastmail.com>
 <HK0PR06MB37796D91EC7290A69F2655E491240@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <HK0PR06MB33800F282095AA96884B2FC0F2350@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <485ec282-568f-458c-a91e-14c89415b8e5@www.fastmail.com>
Message-ID: <HK0PR06MB37793A5D2B57972AFFFBAA0E91330@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Wednesday, September 30, 2020 2:12 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; ChiaWei Wang
> <chiawei_wang@aspeedtech.com>; Joel Stanley <joel@jms.id.au>
> Subject: Re: [PATCH 0/4] Remove LPC register partitioning
> 
> 
> 
> On Mon, 28 Sep 2020, at 17:13, Ryan Chen wrote:
> > Hello Joel & Andrew,
> > 	Those patches are more organize for ASPEED SOC LPC register layout.
> > 	Does those patches have any feedback?
> 
> I support getting the problem fixed. However, the series also needs to fix the
> LPC devicetree binding at
> 
> Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> 
> What's proposed isn't backwards compatible. We need to agree that a
> breaking change is the way we want to go and get Rob's buy-in. Given the
> impact of the change I'd prefer we don't try to maintain backwards
> compatibility. All known users of the binding ship the dtb with the kernel.
> 
> Can we get a v2 with the binding documentation fixed? That will probably need
> some review.
Yes, I will fix the binding documentation and resend the v2 patch for the review.
Thanks.
