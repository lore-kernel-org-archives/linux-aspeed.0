From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 1 Feb 2022 09:42:50 +0100
Subject: [PATCH 0/2] firmware: Add boot information to sysfs
In-Reply-To: <20220201050501.182961-1-joel@jms.id.au>
References: <20220201050501.182961-1-joel@jms.id.au>
Message-ID: <YfjyiuWBeJeHCg7q@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 01, 2022 at 03:34:59PM +1030, Joel Stanley wrote:
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
> This is implemented as a sysfs attribute group registration to be called
> at boot, with the properties described in the ABI document.
> 
> Alternatively we could put the properties in the driver core, and have
> platforms register callbacks for each supported property. This would
> make it harder to insert non-standard properties, with the trade off of
> more code to selectively show supported properties.

It is trivial to selectively show properties in sysfs, the is_visible()
callback is there for this very reason.

So yes, this should be in the driver core so that we do not have random
platform values and fields that have no relation to each other at all.

For example, you could provide these fields for UEFI today, right?  That
would be a good proof if this really can work for multiple systems or
not.

thanks,

greg k-h
