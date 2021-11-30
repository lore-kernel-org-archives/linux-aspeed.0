From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 30 Nov 2021 12:42:54 +0100
Subject: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
In-Reply-To: <20211130113847.1405873-2-neal_liu@aspeedtech.com>
References: <20211130113847.1405873-1-neal_liu@aspeedtech.com>
 <20211130113847.1405873-2-neal_liu@aspeedtech.com>
Message-ID: <YaYOPgzv6hGyXLYg@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 30, 2021 at 07:38:44PM +0800, Neal Liu wrote:
> +Ben.
> ---
> 
> Support qualifier descriptor to pass USB30CV compliance test.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---

The way you wrote this means that everything below the first --- line
will be cut off if it were to be applied.

That is not what you want.

Please fix.

thanks,

greg k-h
