From: Corey Minyard <minyard@acm.org>
Date: Thu, 22 Sep 2022 19:20:32 -0500
Subject: [PATCH] ipmi: kcs: aspeed: Update port address comments
In-Reply-To: <HK0PR06MB37794D51E9DB4A864249F96691519@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20220920020333.601-1-chiawei_wang@aspeedtech.com>
 <YyywI8265vECnEHv@minyard.net>
 <HK0PR06MB37794D51E9DB4A864249F96691519@HK0PR06MB3779.apcprd06.prod.outlook.com>
Message-ID: <Yyz70LckHqyiNhGa@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 23, 2022 at 12:08:07AM +0000, ChiaWei Wang wrote:
> Hi Corey,
> 
> > From: Corey Minyard <tcminyard@gmail.com> On Behalf Of Corey Minyard
> > Sent: Friday, September 23, 2022 2:58 AM
> > 
> > On Tue, Sep 20, 2022 at 10:03:33AM +0800, Chia-Wei Wang wrote:
> > > Remove AST_usrGuide_KCS.pdf as it is no longer maintained.
> > 
> > Even if it's no longer maintained, is it useful?  It seems better to leave in
> > useful documentation unless it has been replaced with something else.
> 
> This document has no permeant public link to access.
> Aspeed has dropped this file but we keep receiving customer request asking for this document.
> The most important part regarding KCS port rule is still kept in the updated comment.

I mean, if you have code that is implementing what is documented, why
did you remove the document?  I don't understand why you would retire
documentation that people still want to use.

I could put it on the IPMI sourceforge or github page as a historical
document.

-corey

> 
> Regards,
> Chiawei
> 
> > 
> > 
> > >
> > > Add more descriptions as the driver now supports the I/O address
> > > configurations for both the KCS Data and Cmd/Status interface
> > > registers.
> > >
> > > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > ---
> > >  drivers/char/ipmi/kcs_bmc_aspeed.c | 29 ++++++++++++++++++-----------
> > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c
> > > b/drivers/char/ipmi/kcs_bmc_aspeed.c
> > > index cdc88cde1e9a..19c32bf50e0e 100644
> > > --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> > > +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> > > @@ -207,17 +207,24 @@ static void aspeed_kcs_updateb(struct
> > > kcs_bmc_device *kcs_bmc, u32 reg, u8 mask,  }
> > >
> > >  /*
> > > - * AST_usrGuide_KCS.pdf
> > > - * 2. Background:
> > > - *   we note D for Data, and C for Cmd/Status, default rules are
> > > - *     A. KCS1 / KCS2 ( D / C:X / X+4 )
> > > - *        D / C : CA0h / CA4h
> > > - *        D / C : CA8h / CACh
> > > - *     B. KCS3 ( D / C:XX2h / XX3h )
> > > - *        D / C : CA2h / CA3h
> > > - *        D / C : CB2h / CB3h
> > > - *     C. KCS4
> > > - *        D / C : CA4h / CA5h
> > > + * We note D for Data, and C for Cmd/Status, default rules are
> > > + *
> > > + * 1. Only the D address is given:
> > > + *   A. KCS1/KCS2 (D/C: X/X+4)
> > > + *      D/C: CA0h/CA4h
> > > + *      D/C: CA8h/CACh
> > > + *   B. KCS3 (D/C: XX2/XX3h)
> > > + *      D/C: CA2h/CA3h
> > > + *   C. KCS4 (D/C: X/X+1)
> > > + *      D/C: CA4h/CA5h
> > > + *
> > > + * 2. Both the D/C addresses are given:
> > > + *   A. KCS1/KCS2/KCS4 (D/C: X/Y)
> > > + *      D/C: CA0h/CA1h
> > > + *      D/C: CA8h/CA9h
> > > + *      D/C: CA4h/CA5h
> > > + *   B. KCS3 (D/C: XX2/XX3h)
> > > + *      D/C: CA2h/CA3h
> > >   */
> > >  static int aspeed_kcs_set_address(struct kcs_bmc_device *kcs_bmc, u32
> > > addrs[2], int nr_addrs)  {
> > > --
> > > 2.25.1
> > >
