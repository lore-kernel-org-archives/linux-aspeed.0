From: Joel Stanley <joel@jms.id.au>
Date: Wed, 20 Sep 2017 15:43:41 +0930
Subject: [PATCH v2 4/4] watchdog: aspeed: Move init to arch_initcall
In-Reply-To: <20170920053020.6860-5-andrew@aj.id.au>
References: <20170920053020.6860-1-andrew@aj.id.au>
 <20170920053020.6860-5-andrew@aj.id.au>
Message-ID: <CACPK8Xdz1iK-4bqZfmfTUYw3zDLxCniwt6LupJq5mo-CCca3XQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 20, 2017 at 3:00 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> Probing at device_initcall time lead to perverse cases where the
> watchdog was probed after, say, I2C devices, which then leaves a
> potentially running watchdog at the mercy of I2C device behaviour and
> bus conditions.
>
> Load the watchdog driver early to ensure that the kernel is patting it
> well before initialising peripherals.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

I agree that we need to make sure the watchdog driver is loaded
earlier. I think this is the correct method, but I'll defer to Guenter
on this one.

Cheers,

Joel
