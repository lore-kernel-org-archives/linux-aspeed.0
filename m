From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 24 Nov 2017 10:50:47 +0100
Subject: [PATCH v3 1/2] gpio: gpiolib: Generalise state persistence beyond
 sleep
In-Reply-To: <20171101040457.1200-2-andrew@aj.id.au>
References: <20171101040457.1200-1-andrew@aj.id.au>
 <20171101040457.1200-2-andrew@aj.id.au>
Message-ID: <CACRpkdaar7b_RJ9GneJB84TGRGasSy8PwzJRr81BAooYmF_VAw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 1, 2017 at 5:04 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> General support for state persistence is added to gpiolib with the
> introduction of a new pinconf parameter to propagate the request to
> hardware. The existing persistence support for sleep is adapted to
> include hardware support if the GPIO driver provides it. Persistence
> continues to be enabled by default; in-kernel consumers can opt out, but
> userspace (currently) does not have a choice.
>
> The *_SLEEP_MAY_LOSE_VALUE and *_SLEEP_MAINTAIN_VALUE symbols are
> renamed, dropping the SLEEP prefix to reflect that the concept is no
> longer sleep-specific.  I feel that renaming to just *_MAY_LOSE_VALUE
> could initially be misinterpreted, so I've further changed the symbols
> to *_TRANSITORY and *_PERSISTENT to address this.
>
> The sysfs interface is modified only to keep consistency with the
> chardev interface in enforcing persistence for userspace exports.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

This does not apply to the Torvalds master HEAD anymore
so please:

- Collect ACKs
- Rebase on Torvalds tree or v4.15-rc1 when it's out
- Resend

The functionality per se looks very nice :) so I want to apply this
ASAP.

Yours,
Linus Walleij
