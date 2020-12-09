From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 9 Dec 2020 07:41:41 +0100
Subject: [PATCH v2 1/2] misc: Add clock control logic into Aspeed LPC
 SNOOP driver
In-Reply-To: <CACPK8XePhJj8HzbLB4QgJQCjTuH_kPq=sWyOhdcGPmptqD6Aqw@mail.gmail.com>
References: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com>
 <CACPK8XePhJj8HzbLB4QgJQCjTuH_kPq=sWyOhdcGPmptqD6Aqw@mail.gmail.com>
Message-ID: <CAK8P3a0jPEjXnqGpeQ=A0Pd0esX+k4EHgbrGr+NAQAx1vO9Q7w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 9, 2020 at 3:17 AM Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 8 Dec 2020 at 09:17, John Wang <wangzhiqiang.bj@bytedance.com> wrote:
> >
> > From: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
> >
> > If LPC SNOOP driver is registered ahead of lpc-ctrl module, LPC
> > SNOOP block will be enabled without heart beating of LCLK until
> > lpc-ctrl enables the LCLK. This issue causes improper handling on
> > host interrupts when the host sends interrupt in that time frame.
> > Then kernel eventually forcibly disables the interrupt with
> > dumping stack and printing a 'nobody cared this irq' message out.
> >
> > To prevent this issue, all LPC sub-nodes should enable LCLK
> > individually so this patch adds clock control logic into the LPC
> > SNOOP driver.
> >
> > Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc
> > chardev")
> >
> > Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
> > Signed-off-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> > Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> Arnd, can you merge this for v5.11, or would you prefer me to do a pull request?
>
> The device tree patch from this series also needs to be added.

Sure, please forward the patches to soc at kernel.org so I can
grab them from patchwork.

      Arnd
