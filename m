From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 25 Jun 2024 14:30:54 +0200
Subject: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
In-Reply-To: <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
 <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>
Message-ID: <2024062556-ladder-canister-1ab1@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 25, 2024 at 02:00:15PM +0200, Markus Elfring wrote:
> > We should verify the bound of the array to assure that host
> > may not manipulate the index to point past endpoint array.
> 
> Why did you not choose an imperative wording for your change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc5#n94

Markus, please stop reviewing USB patches.  This is not helpful at all,
and causes new developers extra work for no reason at all.

You have been warned many times about this, and many people have talked
to you about this.  If you continue, you will have to be banned the
mailing lists, again.

greg k-h
