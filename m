From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 03 Feb 2020 14:37:16 +1030
Subject: [PATCH 1/2] hwrng: Add support for ASPEED RNG
In-Reply-To: <27c5505acd8d09f70ec9cd12982b2e3e@neuralgames.com>
References: <20200120150113.2565-1-linux@neuralgames.com>
 <CACPK8XfuVN3Q=npEoOP-amQS0-wemxcx6LKaHHZEsBAHzq1wzA@mail.gmail.com>
 <4446ffb694c7742ca9492c7360856789@neuralgames.com>
 <575811fd-24ca-409c-8d33-c2152ee401d7@www.fastmail.com>
 <136bbab84d13d8d56a5ac297e415975e@neuralgames.com>
 <b83f2a1f-e1be-433c-8dc8-c469cb38f423@www.fastmail.com>
 <27c5505acd8d09f70ec9cd12982b2e3e@neuralgames.com>
Message-ID: <f6beee98-360c-4239-ab01-86ba41629f9b@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2020, at 10:56, linux at neuralgames.com wrote:
> On 2020-01-27 18:53, Andrew Jeffery wrote:
> > Not that I've looked, but is it feasible to augment timeriomem-rng with
> > the ability to configure the RNG rather than implement a new driver? 
> > Why
> > didn't you go that route?
> > 
> 
> I decided to wrote the Aspeed-RNG driver because was under the 
> impression that the community would prefer dedicated drivers over 
> generic ones for these SOCs. 

I think we should leverage existing work where we can. Lets not make
more extra for ourselves :)

> However, enhancing timeriomem-rng module 
> is not hard at all.  As I matter of fact, I'm currently testing changes 
> to timeriomem-rng and so far so good. If you would like to have a quick 
> look to my changes, I just pushed patches to the same repo a couple of 
> hours ago:  
> https://github.com/operezmuena/aspeed-rng-testing/tree/master/patches

I think this is a good approach  so long as we can create a clean interface
to the control MMIO(s) inside the driver, i.e. we shouldn't be baking any
Aspeed-specific information into generic sections of code. Usually this
means sticking a pointer to an ops struct in the data member of the
matching OF ID struct.

Input from the RNG maintainers will be helpful here.

Andrew
