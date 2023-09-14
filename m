From: Maciej W. Rozycki <macro@orcam.me.uk>
Date: Thu, 14 Sep 2023 20:01:01 +0100 (BST)
Subject: [PATCH tty v1 00/74] serial: wrappers for uart port lock
In-Reply-To: <20230914183831.587273-1-john.ogness@linutronix.de>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
Message-ID: <alpine.DEB.2.21.2309141959100.57368@angie.orcam.me.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 14 Sep 2023, John Ogness wrote:

> Patches 2-74 switch all uart port locking call sites to use the new
> wrappers. These patches were automatically generated using coccinelle.

 Hmm, no need to do this for drivers/tty/serial/zs.c?

  Maciej
