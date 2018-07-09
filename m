From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 9 Jul 2018 09:52:33 +0200
Subject: [PATCH] drivers/misc: Aspeed LPC snoop output using misc chardev
In-Reply-To: <20180706182531.137362-1-benjaminfair@google.com>
References: <20180706182531.137362-1-benjaminfair@google.com>
Message-ID: <20180709075233.GF13479@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 06, 2018 at 11:25:32AM -0700, Benjamin Fair wrote:
> From: Robert Lippert <rlippert@google.com>
> 
> Provides the data bytes snooped over the LPC snoop bus to userspace
> as a (blocking) misc character device.

If this is a debugging thing, why not just use debugfs instead of a char
device?  That should make this code simpler overall, and you can do
whatever you want with debugfs.

thanks,

greg k-h
