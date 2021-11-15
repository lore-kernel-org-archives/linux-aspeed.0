From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 15 Nov 2021 19:49:57 +0100
Subject: [PATCH v3 06/13] peci: Add device detection
In-Reply-To: <20211115182552.3830849-7-iwona.winiarska@intel.com>
References: <20211115182552.3830849-1-iwona.winiarska@intel.com>
 <20211115182552.3830849-7-iwona.winiarska@intel.com>
Message-ID: <YZKr1Rqfx6Cmw+Ok@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 15, 2021 at 07:25:45PM +0100, Iwona Winiarska wrote:
> +void peci_device_destroy(struct peci_device *device)
> +{
> +	bool killed;
> +
> +	device_lock(&device->dev);
> +	killed = kill_device(&device->dev);

Eeek, why call this?

> +	device_unlock(&device->dev);
> +
> +	if (!killed)
> +		return;

What happened if something changed after you unlocked it?

Why is kill_device() required at all?  That's a very rare function to
call, and one that only one "bus" calls today because it is very
special (i.e. crazy and broken...)

thanks,

greg k-h
