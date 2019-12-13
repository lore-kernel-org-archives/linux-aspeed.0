From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 13 Dec 2019 12:12:38 +1030
Subject: [PATCH v2 06/12] drivers/soc: Add Aspeed XDMA Engine Driver
In-Reply-To: <bbe9045e-c5ca-541c-1ee9-0f5ef246a27b@linux.vnet.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
 <1575566112-11658-7-git-send-email-eajames@linux.ibm.com>
 <de395d95-15f4-4df3-873d-ce89ae008ed3@www.fastmail.com>
 <bffadb0a-aba7-d799-b2ef-a4adb3259c4b@linux.ibm.com>
 <f597202e-0d5a-4b76-ba0a-a6f0a857b289@www.fastmail.com>
 <bbe9045e-c5ca-541c-1ee9-0f5ef246a27b@linux.vnet.ibm.com>
Message-ID: <601efc97-714b-40af-b3a0-e4687c43be46@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 13 Dec 2019, at 05:46, Eddie James wrote:
> 
> On 12/11/19 10:52 PM, Andrew Jeffery wrote:
> >
> > On Thu, 12 Dec 2019, at 07:09, Eddie James wrote:
> >> On 12/10/19 9:47 PM, Andrew Jeffery wrote:
> >>> On Fri, 6 Dec 2019, at 03:45, Eddie James wrote:
> >>>> +
> >>>> +	regmap_update_bits(sdmc, SDMC_REMAP, ctx->chip->sdmc_remap,
> >>>> +			   ctx->chip->sdmc_remap);
> >>> I disagree with doing this. As mentioned on the bindings it should be up to
> >>> the platform integrator to ensure that this is configured appropriately.
> >>
> >> Probably so, but then how does one actually configure that elsewhere? Do
> >> you mean add code to the edac driver (and add support for the ast2600)
> >> to read some dts properties to set it?
> > Right. That's where I was going. I don't expect you to do that as part of this
> > patch series, but if you could separate this code out into separate patches
> > (dealing with the sdmc property in the devicetree binding as well) we can at
> > least concentrate on getting the core XDMA driver in and work out how to
> > move forward with configuring the memory controller later.
> 
> 
> Yea... my concern is that then we end up with a driver upstream that 
> doesn't actually work. Same concern with the reset thing you mentioned 
> below.

How would it not work? It would just be up to the platform integrator to make
sure the stars align right? If they do then there should be no problem. Whacking
the memory controller here is done out of convenience.

We can still carry the separate patches adding this and the reset behaviour in
e.g. the openbmc kernel tree if necessary.

Andrew
