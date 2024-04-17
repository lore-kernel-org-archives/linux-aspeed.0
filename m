From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 17 Apr 2024 16:32:01 +0930
Subject: [PATCH 3/3] ARM: dts: aspeed: Update Odyssey SBEFIFO compatible
 strings
In-Reply-To: <2ee4084d-1891-4ea4-ba3d-b99ee1d7b5fb@linux.ibm.com>
References: <20240412144358.204129-1-eajames@linux.ibm.com>
	 <20240412144358.204129-4-eajames@linux.ibm.com>
	 <5c6f58cc13492988d307504d55cc5d31a512ab8c.camel@codeconstruct.com.au>
	 <0363badd-f5b0-42bd-bdd5-de6e7b5ee8c6@linux.ibm.com>
	 <90ced7e271213da481f7c0ec883d0189671563e8.camel@codeconstruct.com.au>
	 <2ee4084d-1891-4ea4-ba3d-b99ee1d7b5fb@linux.ibm.com>
Message-ID: <a935d2a6ec3b0ab847b662d05bcea8408077511d.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-04-16 at 09:48 -0500, Eddie James wrote:
> On 4/15/24 19:06, Andrew Jeffery wrote:
> > On Mon, 2024-04-15 at 09:59 -0500, Eddie James wrote:
> > > On 4/14/24 19:54, Andrew Jeffery wrote:
> > > > On Fri, 2024-04-12 at 09:43 -0500, Eddie James wrote:
> > > > > Set the new compatible string for Odyssey SBEFIFOs so that they
> > > > > don't collect async FFDC.
> > > > > 
> > > > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > > > > ---
> > > > >    .../dts/aspeed/aspeed-bmc-ibm-everest.dts     | 64 +++++++++----------
> > > > >    .../arm/boot/dts/aspeed/ibm-power10-quad.dtsi | 64 +++++++++----------
> > > > >    2 files changed, 64 insertions(+), 64 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> > > > > index 214b2e6a4c6d..3a2bfdf035cb 100644
> > > > > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> > > > > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> > > > > @@ -2545,7 +2545,7 @@ scom500: scom at 1000 {
> > > > >    						};
> > > > >    
> > > > >    						sbefifo500: sbefifo at 2400 {
> > > > > -							compatible = "ibm,p9-sbefifo";
> > > > > +							compatible = "ibm,ody-sbefifo";
> > > > >    							reg = <0x2400 0x400>;
> > > > >    							#address-cells = <1>;
> > > > >    							#size-cells = <0>;
> > > > Bit of a drive-by comment as I'm not really holding any stakes here,
> > > > but did the hardware actually change?
> > > 
> > > Yes, the hardware did change in the Odyssey version.
> > Should there not be a new platform DTS then? Seems a bit puzzling, but
> > again this is a bit of a drive-by comment.
> 
> 
> Ah, I should clarify. The SBE hardware was changed between P9/P10 and 
> Odyssey versions. The Odyssey hasn't changed. The difference in the SBE 
> wasn't apparent when we initially added support for Odyssey, so this is 
> effectively a bug fix on the new hardware. There is no new platform.

That sounds like good info for the commit message. Do you mind updating
it?

Andrew
