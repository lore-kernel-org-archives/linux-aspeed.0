From: Markus Elfring <Markus.Elfring@web.de>
Date: Tue, 25 Jun 2024 14:00:15 +0200
Subject: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
In-Reply-To: <20240625022306.2568122-1-make24@iscas.ac.cn>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
Message-ID: <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> We should verify the bound of the array to assure that host
> may not manipulate the index to point past endpoint array.

Why did you not choose an imperative wording for your change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc5#n94


> Found by static analysis.

Were any special tools involved?


How do you think about to add any tags (like ?Fixes? and ?Cc?) accordingly?

Regards,
Markus
