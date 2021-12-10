From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 10 Dec 2021 16:15:26 +0100
Subject: [PATCH 1/2] gpio: aspeed: Convert aspeed_gpio.lock to raw_spinlock
In-Reply-To: <20211204171027.451220-1-iwona.winiarska@intel.com>
References: <20211204171027.451220-1-iwona.winiarska@intel.com>
Message-ID: <CAMRc=MdBp6HOKtV2QDrGYrqneXMbJZs6zbXCGnq_B9a4JA2i8g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Dec 4, 2021 at 6:11 PM Iwona Winiarska
<iwona.winiarska@intel.com> wrote:
>
> The gpio-aspeed driver implements an irq_chip which need to be invoked
> from hardirq context. Since spin_lock() can sleep with PREEMPT_RT, it is
> no longer legal to invoke it while interrupts are disabled.
> This also causes lockdep to complain about:
> [    0.649797] [ BUG: Invalid wait context ]
> because aspeed_gpio.lock (spin_lock_t) is taken under irq_desc.lock
> (raw_spinlock_t).
> Let's use of raw_spinlock_t instead of spinlock_t.
>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> ---

Applied, thanks!

Bart
