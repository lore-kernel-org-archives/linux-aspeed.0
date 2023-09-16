From: John Ogness <john.ogness@linutronix.de>
Date: Sat, 16 Sep 2023 21:30:54 +0206
Subject: [PATCH tty v1 00/74] serial: wrappers for uart port lock
In-Reply-To: <alpine.DEB.2.21.2309151739290.57368@angie.orcam.me.uk>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <alpine.DEB.2.21.2309141959100.57368@angie.orcam.me.uk>
 <87il8b1w3l.ffs@tglx>
 <alpine.DEB.2.21.2309151739290.57368@angie.orcam.me.uk>
Message-ID: <87edixncop.fsf@jogness.linutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2023-09-15, "Maciej W. Rozycki" <macro@orcam.me.uk> wrote:
> Maybe dz.c shouldn't be touched by this series then?

Correct. This series is only wrapping the uart port lock, which dz.c is
not using.

> Though obviously both drivers will have to be eventually adapted for
> the ultimate console rework.

Correct.

Thanks for clarifying how the hardware works.

John
