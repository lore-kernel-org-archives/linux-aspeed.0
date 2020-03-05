From: Tao Ren <rentao.bupt@gmail.com>
Date: Wed, 4 Mar 2020 21:56:27 -0800
Subject: [PATCH] usb: gadget: aspeed: improve vhub port irq handling
In-Reply-To: <8a9033d5e76951f5bec39531c5d0e0d6ef963ee5.camel@kernel.crashing.org>
References: <20200305023859.21057-1-rentao.bupt@gmail.com>
 <8a9033d5e76951f5bec39531c5d0e0d6ef963ee5.camel@kernel.crashing.org>
Message-ID: <20200305055627.GA2296@taoren-ubuntuvm>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 05, 2020 at 02:35:08PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2020-03-04 at 18:38 -0800, rentao.bupt at gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > This patch evaluates vhub ports' irq mask before going through per-
> > port
> > irq handling one by one, which helps to speed up irq handling in case
> > there is no port interrupt.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> Looks reasonable, but did you try a find_next_bit() loop and whether
> that's faster ?

Make sense. It should be more efficient especially when most ports are
idle (and I guess it's a common case). Will try and send out v2 soon.


Cheers,

Tao
