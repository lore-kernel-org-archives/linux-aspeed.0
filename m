From: Rob Herring <robh@kernel.org>
Date: Wed, 1 Nov 2017 19:15:31 -0500
Subject: [PATCH v3 1/2] gpio: gpiolib: Generalise state persistence
 beyond sleep
In-Reply-To: <20171101040457.1200-2-andrew@aj.id.au>
References: <20171101040457.1200-1-andrew@aj.id.au>
 <20171101040457.1200-2-andrew@aj.id.au>
Message-ID: <20171102001531.6j7isyrcwjjwovho@rob-hp-laptop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 01, 2017 at 03:04:56PM +1100, Andrew Jeffery wrote:
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
> ---
>  drivers/gpio/gpiolib-of.c               |  6 ++--
>  drivers/gpio/gpiolib-sysfs.c            | 14 +++++---
>  drivers/gpio/gpiolib.c                  | 61 ++++++++++++++++++++++++++++++---
>  drivers/gpio/gpiolib.h                  |  2 +-

>  include/dt-bindings/gpio/gpio.h         |  6 ++--

Acked-by: Rob Herring <robh@kernel.org>

>  include/linux/gpio/consumer.h           |  8 +++++
>  include/linux/gpio/machine.h            |  4 +--
>  include/linux/of_gpio.h                 |  2 +-
>  include/linux/pinctrl/pinconf-generic.h |  2 ++
>  9 files changed, 87 insertions(+), 18 deletions(-)
