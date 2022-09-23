From: Corey Minyard <minyard@acm.org>
Date: Thu, 22 Sep 2022 19:46:31 -0500
Subject: [PATCH] ipmi: kcs: aspeed: Update port address comments
In-Reply-To: <HK0PR06MB377992E9AF7B91CE41452B4A91519@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20220920020333.601-1-chiawei_wang@aspeedtech.com>
 <YyywI8265vECnEHv@minyard.net>
 <HK0PR06MB37794D51E9DB4A864249F96691519@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <Yyz70LckHqyiNhGa@minyard.net>
 <HK0PR06MB377992E9AF7B91CE41452B4A91519@HK0PR06MB3779.apcprd06.prod.outlook.com>
Message-ID: <Yy0B5+jzc7R7Drz7@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 23, 2022 at 12:38:08AM +0000, ChiaWei Wang wrote:
> > From: Corey Minyard <tcminyard@gmail.com> On Behalf Of Corey Minyard
> > Sent: Friday, September 23, 2022 8:21 AM
> > 
> > On Fri, Sep 23, 2022 at 12:08:07AM +0000, ChiaWei Wang wrote:
> > > Hi Corey,
> > >
> > > > From: Corey Minyard <tcminyard@gmail.com> On Behalf Of Corey
> > Minyard
> > > > Sent: Friday, September 23, 2022 2:58 AM
> > > >
> > > > On Tue, Sep 20, 2022 at 10:03:33AM +0800, Chia-Wei Wang wrote:
> > > > > Remove AST_usrGuide_KCS.pdf as it is no longer maintained.
> > > >
> > > > Even if it's no longer maintained, is it useful?  It seems better to
> > > > leave in useful documentation unless it has been replaced with something
> > else.
> > >
> > > This document has no permeant public link to access.
> > > Aspeed has dropped this file but we keep receiving customer request asking
> > for this document.
> > > The most important part regarding KCS port rule is still kept in the updated
> > comment.
> > 
> > I mean, if you have code that is implementing what is documented, why did
> > you remove the document?  I don't understand why you would retire
> > documentation that people still want to use.
> > 
> > I could put it on the IPMI sourceforge or github page as a historical document.
> 
> This document is a personal note of one of our former employee.
> It is known to only the owner and his supporting customers.
> Most of us has no access to this document.
> In addition, after chip revision, certain information is not guaranteed anymore.

Ok, I'll take the patch.  Thanks.

-corey

> 
> Regards,
> Chiawei
