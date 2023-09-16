From: John Ogness <john.ogness@linutronix.de>
Date: Sat, 16 Sep 2023 21:48:14 +0206
Subject: [PATCH tty v1 00/74] serial: wrappers for uart port lock
In-Reply-To: <1446dc6-5ab0-629-45c8-3b7d8c76367d@linux.intel.com>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <1446dc6-5ab0-629-45c8-3b7d8c76367d@linux.intel.com>
Message-ID: <878r95nbvt.fsf@jogness.linutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2023-09-15, Ilpo J?rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> Would this also be useful to enable printing to console while under
> port's lock (by postponing the output until the lock is released)?
>
> E.g., 8250_dw.c has had this commented out since the dawn on time:
>         /*
>          * FIXME: this deadlocks if port->lock is already held
>          * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
>          */

Yes, this will fix such issues. However, only for consoles that are
converted to the new NBCON console type.

Good news, the 8250 driver will be the flagship driver that is converted
as part of the rework. So this particular issue will be solved then. I
will try to remember this so that I can remove the FIXME in the series.

Thanks for mentioning it.

John
