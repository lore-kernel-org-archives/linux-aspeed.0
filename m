From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 22 Apr 2022 08:48:15 +0200
Subject: [PATCH v3 0/3] firmware: Add boot information to sysfs
In-Reply-To: <20220204072234.304543-1-joel@jms.id.au>
References: <20220204072234.304543-1-joel@jms.id.au>
Message-ID: <YmJPrxB8x/zE4Vy7@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 04, 2022 at 05:52:31PM +1030, Joel Stanley wrote:
> v3 resolves Greg's review for the bootinfo header and macros, and drops
> uart_boot as it's unlikely to be common across platforms.
> 
> v2 reworks the series to put the sysfs properties in the core, and
> optionally show them with the is_visible() callback.
> 
> This is the second iteration of this idea. The first used socinfo
> custom attribute groups, but Arnd suggested we make this something
> standardised under /sys/firmware instead:
> 
>  http://lore.kernel.org/all/CAK8P3a3MRf0aGt1drkgsuZyBbeoy+S7Ha18SBM01q+3f33oL+Q at mail.gmail.com
> 
> Some ARM systems have a firmware that provides a hardware root of
> trust. It's useful for the system to know how this root of trust has
> been configured, so provide a standardised interface that expose this
> information to userspace.
> 
> This is implemented as a sysfs attribute group registration in the
> driver core, with platforms populating values obtained from firmware at
> kernel boot time.
> 
> Patch 2 provides a user of the properties on an ARM system.
> 
> Patch 3 is new in v2 and is an example of populating bootinfo with the
> EFI secure boot status.

I would like arch maintainers to review this before it going any
further.

thanks,

greg k-h
