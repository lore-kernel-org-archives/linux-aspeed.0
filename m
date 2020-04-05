From: Andrew Jeffery <andrew@aj.id.au>
Date: Sun, 05 Apr 2020 16:30:09 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_0/3]_ipmi:_kcs-bmc:_Rework_bindings_to_clean_up_?=
 =?UTF-8?Q?DT_warnings?=
In-Reply-To: <20200403130840.GR2910@minyard.net>
References: <cover.fe20dfec1a7c91771c6bb574814ffb4bb49e2136.1576462051.git-series.andrew@aj.id.au>
 <7734002a-181e-4baf-b9a3-af66894acc16@www.fastmail.com>
 <20200403130840.GR2910@minyard.net>
Message-ID: <69bfc045-2059-4d37-af7a-52f5840664cf@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 3 Apr 2020, at 23:38, Corey Minyard wrote:
> On Fri, Apr 03, 2020 at 02:20:21PM +1030, Andrew Jeffery wrote:
> > 
> > 
> > On Mon, 16 Dec 2019, at 12:57, Andrew Jeffery wrote:
> > > Hello,
> > > 
> > > This is a short series reworking the devicetree binding and driver for the
> > > ASPEED BMC KCS devices. With the number of supported ASPEED BMC devicetrees the
> > > changes enable removal of more than 100 lines of warning output from dtc.
> > > 
> > > v1 can be found here:
> > > 
> > > https://lore.kernel.org/lkml/cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew at aj.id.au/
> > > 
> > > v2 cleans up the commit message of 2/3 and changes the name of the property
> > > governing the LPC IO address for the KCS devices.
> > 
> > Ping?
> 
> Sorry, I've been busy.

No worries, so have I. I was surprised when I found it had been 4 months :)

>  I've looked this over and it seems ok, and it's
> in my next tree.

Thanks.

Andrew
