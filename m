From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Thu, 15 Jul 2021 16:42:05 +0000
Subject: [PATCH 07/14] peci: Add peci-aspeed controller driver
In-Reply-To: <b894ba5e-e1ae-e5dd-87be-dc33912dd5c0@infradead.org>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-8-iwona.winiarska@intel.com>
 <b894ba5e-e1ae-e5dd-87be-dc33912dd5c0@infradead.org>
Message-ID: <787288238eba562e1e1927469c7e8dbb2b4912df.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2021-07-12 at 22:02 -0700, Randy Dunlap wrote:
> On 7/12/21 3:04 PM, Iwona Winiarska wrote:
> > diff --git a/drivers/peci/controller/Kconfig
> > b/drivers/peci/controller/Kconfig
> > new file mode 100644
> > index 000000000000..8ddbe494677f
> > --- /dev/null
> > +++ b/drivers/peci/controller/Kconfig
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +config PECI_ASPEED
> > +???????tristate "ASPEED PECI support"
> > +???????depends on ARCH_ASPEED || COMPILE_TEST
> > +???????depends on OF
> > +???????depends on HAS_IOMEM
> > +???????help
> > +???????? Enable this driver if you want to support ASPEED PECI
> > controller.
> > +
> > +???????? This driver can be also build as a module. If so, the
> > module
> 
> ????????????????????? can also be built as a module.

Thank you Randy - I'll fix this in v2.

-Iwona

> 
> > +???????? will be called peci-aspeed.
> 
> 
> -- 
> ~Randy
> 

