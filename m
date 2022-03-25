From: Howard Chiu <howard_chiu@aspeedtech.com>
Date: Fri, 25 Mar 2022 01:57:23 +0000
Subject: [PATCH v1 2/3] dt-bindings: clock: Add AST2600 video engine reset
 definition
In-Reply-To: <527e9d9e-0dac-3a97-da83-068891a41381@quicinc.com>
References: <SG2PR06MB2315F68B23BB0998B8F7E93EE6199@SG2PR06MB2315.apcprd06.prod.outlook.com>
 <527e9d9e-0dac-3a97-da83-068891a41381@quicinc.com>
Message-ID: <HK0PR06MB23073BAA6569EE0AD5527D00E61A9@HK0PR06MB2307.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jae

************* Email Confidentiality Notice ********************
DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.

> -----Original Message-----
> From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> Sent: Thursday, March 24, 2022 9:51 PM
> To: Howard Chiu <howard_chiu@aspeedtech.com>; robh+dt at kernel.org; Joel
> Stanley <joel@jms.id.au>; andrew at aj.id.au; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH v1 2/3] dt-bindings: clock: Add AST2600 video engine reset
> definition
> 
> 
> 
> On 3/24/2022 12:27 AM, Howard Chiu wrote:
> > Reset bit for VE is 6
> >
> > Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
> > ---
> >   include/dt-bindings/clock/ast2600-clock.h | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/include/dt-bindings/clock/ast2600-clock.h
> > b/include/dt-bindings/clock/ast2600-clock.h
> > index 62b9520a00fd..a7d0ad9539eb 100644
> > --- a/include/dt-bindings/clock/ast2600-clock.h
> > +++ b/include/dt-bindings/clock/ast2600-clock.h
> > @@ -110,6 +110,7 @@
> >   #define ASPEED_RESET_PCIE_DEV_OEN	20
> >   #define ASPEED_RESET_PCIE_RC_O		19
> >   #define ASPEED_RESET_PCIE_RC_OEN	18
> > +#define ASPEED_RESET_VIDEO		6
> 
> You don't need to add 'resets' for video node in DT so it wouldn't be needed.
> 
Got it.
> -Jae
> 
> >   #define ASPEED_RESET_PCI_DP		5
> >   #define ASPEED_RESET_AHB		1
> >   #define ASPEED_RESET_SDRAM		0
