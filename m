From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 14 Jan 2021 10:57:13 +1030
Subject: [PATCH, v1 1/1] gpio: aspeed: Add gpio base address reading
In-Reply-To: <20210113223808.31626-2-hongweiz@ami.com>
References: <20210113223808.31626-1-hongweiz@ami.com>
 <20210113223808.31626-2-hongweiz@ami.com>
Message-ID: <775b31f0-c74c-4ebe-9588-bca3ee423383@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Thu, 14 Jan 2021, at 09:08, Hongwei Zhang wrote:
> Add gpio base address reading in the driver; in old code, it just
> returns -1 to gpio->chip.base.

Why do you want to do this? It feels hacky. The base address only affects the 
legacy sysfs number-space, and even then if you're using the sysfs interface 
you can discover the base address for a specific gpiochip via the associated 
attribute. For example:

# cat /sys/bus/platform/devices/1e780000.gpio/gpio/gpiochip*/base
816

I feel that you should instead be changing your userspace not to assume a fixed 
value.

Finally, the base value is a linux-specific thing and doesn't belong in the 
devicetree, and if it did, you would also need to update the devicetree binding 
in Documentation/.

Cheers,

Andrew
