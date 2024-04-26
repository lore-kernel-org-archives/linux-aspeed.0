From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 26 Apr 2024 09:33:32 +0930
Subject: [PATCH v2] ARM: dts: aspeed: Add IBM P11 BMC boards
In-Reply-To: <7dd9ba1b-6477-4c09-a571-57002cbfa8b7@linux.ibm.com>
References: <20240415154931.10775-1-eajames@linux.ibm.com>
	 <48ad6bcccae315e68bc0aa10669eed645c495139.camel@codeconstruct.com.au>
	 <7dd9ba1b-6477-4c09-a571-57002cbfa8b7@linux.ibm.com>
Message-ID: <6357235a4a42e889a2b6d7d7ad5511ded4cc29d8.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-04-25 at 16:41 -0500, Eddie James wrote:
> On 4/15/24 19:02, Andrew Jeffery wrote:
> > On Mon, 2024-04-15 at 10:49 -0500, Eddie James wrote:
> > > Add the Blueridge and Fuji BMC systems.
> > > 
> > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > > ---
> > > Changes since v1:
> > >   - Change "ody" to "odyssey"
> > > 
> > >   arch/arm/boot/dts/aspeed/Makefile             |    2 +
> > >   .../dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 1752 +++++++
> > >   .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 4016 +++++++++++++++++
> > >   .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 1704 +++++++
> > >   4 files changed, 7474 insertions(+)
> > A few points:
> > 
> > - Altogether this patch is pretty large. Can we do one for each of the
> > FSI topology and the platforms?
> > 
> > - The only list to which you've sent the patch is linux-aspeed, which
> > doesn't appear to be archived on lore. Can you please add at least one
> > that is? There are a few that should probably be included regardless.
> > 
> > - I don't plan to merge the patch until it has had review from ideally
> > more than one other IBMer
> > 
> > On the review front:
> > 
> > It looks like you still need to update
> > Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml with the new
> > platform compatible strings.
> > 
> > Also, can you please run
> > 
> > ```
> > make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-{blueridge,fuji}.dtb
> > ```
> > 
> > and address the warnings? This is best done by first applying the patch
> > on top of my tree below. It goes some way to eliminating many of the
> > warnings currently produced for the Aspeed BMC SoCs:
> > 
> > https://github.com/amboar/linux/tree/dt-warnings/all
> 
> 
> Thanks, I've sent v3. One patch has turned into 14 to address the 
> warnings...
> 

Super work, thanks for that.

>  There were still many but they're almost all from 
> aspeed-g6.dtsi.
> 

This is based on top of my WIP series fixing a bunch of warnings, or on
top of an upstream tag for submission? Admittedly I didn't fix them all
but I did clean up a decent chunk of what was there.

>  The only remaining ones from Blueridge/Fuji that I saw 
> were for undocumented compatibles for max31785 and pca955x.
> 

Fantastic.

> Those 
> bindings exist but are not in yaml format so the tool doesn't pick them 
> up. I'm sure those can be addressed at another time...

Yep, sounds good.

Thanks for your efforts.

Andrew

