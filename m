From: Troy Lee <troy_lee@aspeedtech.com>
Date: Thu, 3 Dec 2020 01:27:27 +0000
Subject: [PATCH v2 3/3] edac: Supporting AST2400 and AST2600 edac driver
In-Reply-To: <20201202182349.GJ2951@zn.tnic>
References: <20201202063612.21241-1-troy_lee@aspeedtech.com>
 <20201202063612.21241-3-troy_lee@aspeedtech.com>
 <CACPK8XcBTm8-cAPmtswHbYAf2B+PdBiZ2s1XK1UqKA_NQX_-mw@mail.gmail.com>
 <PS1PR06MB26008E4BCB805553EDEC45038AF30@PS1PR06MB2600.apcprd06.prod.outlook.com>
 <b6dd3a91-abe7-4e9d-b801-6e54e4c88827@www.fastmail.com>
 <20201202182349.GJ2951@zn.tnic>
Message-ID: <PS1PR06MB2600D6A1E73D89EA0D0D59DC8AF20@PS1PR06MB2600.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Broislav and Andrew,

I removed these exported function and submitted v3 PATCH.

Thanks,
Troy Lee

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Thursday, December 3, 2020 2:24 AM
> To: Andrew Jeffery <andrew@aj.id.au>
> Cc: Troy Lee <troy_lee@aspeedtech.com>; Joel Stanley <joel@jms.id.au>; open
> list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; Tony Luck <tony.luck@intel.com>; Ryan Chen
> <ryan_chen@aspeedtech.com>; James Morse <james.morse@arm.com>;
> moderated list:ARM/ASPEED MACHINE SUPPORT
> <linux-aspeed@lists.ozlabs.org>; open list <linux-kernel@vger.kernel.org>;
> Robert Richter <rrichter@marvell.com>; leetroy at gmail.com; Rob Herring
> <robh+dt@kernel.org>; Stefan M Schaeckeler <sschaeck@cisco.com>; Mauro
> Carvalho Chehab <mchehab@kernel.org>; moderated list:ARM/ASPEED
> MACHINE SUPPORT <linux-arm-kernel@lists.infradead.org>; open
> list:EDAC-CORE <linux-edac@vger.kernel.org>
> Subject: Re: [PATCH v2 3/3] edac: Supporting AST2400 and AST2600 edac
> driver
> 
> On Thu, Dec 03, 2020 at 01:32:44AM +1030, Andrew Jeffery wrote:
> > On Wed, 2 Dec 2020, at 19:11, Troy Lee wrote:
> > > Hi Joel,
> > >
> > > Thanks for the suggestion, I'll fix the review and create an new
> > > patch against latest Linux branch. Those exported function will be
> > > referenced in other driver yet to be upstream, so should I move
> > > those exported functions out of this patch?
> > >
> >
> > Yes, let's leave the exports out of this patch, and add them in when
> > you send the patch that depends on them.
> 
> And when you do, almost all new exports are EXPORT_SYMBOL_GPL - not
> EXPORT_SYMBOL.
> 
> Also, I'd like to see how those exports are going to be used. An EDAC driver
> function exported to another driver sounds strange. We have only one other
> case like this in the EDAC tree:
> 
> drivers/edac/amd64_edac.c:554:EXPORT_SYMBOL_GPL(amd64_get_dram_hol
> e_info);
> 
> and even that is not really needed...
> 
> Thx.
> 
> --
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
