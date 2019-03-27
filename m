From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 28 Mar 2019 01:45:42 +0900
Subject: [PATCH v7 2/2] drivers/misc: Add Aspeed P2A control driver
In-Reply-To: <20190312163101.155910-1-venture@google.com>
References: <20190312163101.155910-1-venture@google.com>
Message-ID: <20190327164542.GC11712@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 12, 2019 at 09:31:01AM -0700, Patrick Venture wrote:
> +	phys_addr_t mem_base;

Is this really a 32bit value?

Your ioctl thinks it is:

> +struct aspeed_p2a_ctrl_mapping {
> +	__u32 addr;

Does this driver not work on a 64bit kernel?

> +	__u32 length;
> +	__u32 flags;
> +};

addr really should be __u32 here so you don't have to mess with 32/64
bit user/kernel issues, right?

thanks,

greg k-h
