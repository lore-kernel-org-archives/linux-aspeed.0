From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 18 Sep 2023 10:26:38 +0200
Subject: [PATCH tty v1 00/74] serial: wrappers for uart port lock
In-Reply-To: <87y1h3lwjh.fsf@jogness.linutronix.de>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <87y1h3lwjh.fsf@jogness.linutronix.de>
Message-ID: <2023091826-seventy-opium-17b8@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 18, 2023 at 10:29:30AM +0206, John Ogness wrote:
> On 2023-09-14, John Ogness <john.ogness@linutronix.de> wrote:
> > Provide and use wrapper functions for spin_[un]lock*(port->lock)
> > invocations so that the console mechanics can be applied later on at a
> > single place and does not require to copy the same logic all over the
> > drivers.
> 
> For the full 74-patch series:
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> Sorry that my SoB was missing from the initial posting.

Thanks for this, I'll rebuild my tree with this added.

greg k-h
