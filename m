From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Fri, 27 Aug 2021 08:49:16 +0000
Subject: [PATCH v3 3/4] soc: aspeed: Add eSPI driver
In-Reply-To: <CACPK8Xf1g2fp5X3ELBUyjzP6Fmvt1XWLU_UgCKdZaDVjdyKryQ@mail.gmail.com>
References: <20210826061623.6352-4-chiawei_wang@aspeedtech.com>
 <202108270732.OvBQ4K3D-lkp@intel.com>
 <HK0PR06MB377927BDCA9CC79B598251B291C89@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <CACPK8Xf1g2fp5X3ELBUyjzP6Fmvt1XWLU_UgCKdZaDVjdyKryQ@mail.gmail.com>
Message-ID: <HK0PR06MB3779B6CD28A84D3DC651211191C89@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Joel Stanley <joel@jms.id.au>
> Sent: Friday, August 27, 2021 1:49 PM
> 
> On Fri, 27 Aug 2021 at 03:52, ChiaWei Wang
> <chiawei_wang@aspeedtech.com> wrote:
> >
> > Aspeed 5th and 6th generation SoCs are based on the ARM 32-bits
> architecture.
> > Should we follow the report to make the driver 64-bits compatible?
> > Or revise the driver to use more specific data types?
> 
> Yes, in general it's expected your driver will compile cleanly for 64-bit
> architectures. This helps with testing and static analysis, where CI builds all the
> drivers for x86.

Understood. Will fix the data type issue in the next submission.
Thanks.

Chiawei
