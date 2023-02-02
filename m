From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 2 Feb 2023 02:59:18 +0000
Subject: [linux-next:master] BUILD REGRESSION
 66eee64b235411d512bed4d672c2d00683239daf
In-Reply-To: <76f4dea0-9a39-4238-a213-0167477f5d54@app.fastmail.com>
References: <63da97b5.3V1HSQEat507LFIr%lkp@intel.com>
 <76f4dea0-9a39-4238-a213-0167477f5d54@app.fastmail.com>
Message-ID: <TY2PR06MB321334CFD4ED1BD4AF97965380D69@TY2PR06MB3213.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Hi Neal,
> 
> On Thu, 2 Feb 2023, at 03:17, kernel test robot wrote:
> > tree/branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > master
> > branch HEAD: 66eee64b235411d512bed4d672c2d00683239daf  Add
> linux-next
> > specific files for 20230201
> >
> >
> > Unverified Error/Warning (likely false positive, please contact us if
> > interested):
> >
> > drivers/crypto/aspeed/aspeed-acry.c:295:37: sparse: sparse: incorrect
> > type in assignment (different base types)
> > drivers/crypto/aspeed/aspeed-acry.c:305:28: sparse: sparse: cast
> > removes address space '__iomem' of expression
> > drivers/crypto/aspeed/aspeed-acry.c:606:24: sparse: sparse: symbol
> > 'aspeed_acry_akcipher_algs' was not declared. Should it be static?
> 
> Can you please look into these issues with the ACRY driver?
> 
> Cheers,
> 
> Andrew

I just send patch to fix the first 2 warnings, and the last one warning is already fixed by another patch.
[PATCH-next] crypto: aspeed: fix type warnings
https://patchwork.ozlabs.org/project/linux-aspeed/patch/20230119014859.1900136-1-yangyingliang at huawei.com/
Thanks

-Neal
