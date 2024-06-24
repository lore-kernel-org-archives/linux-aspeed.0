From: Markus Elfring <Markus.Elfring@web.de>
Date: Mon, 24 Jun 2024 17:56:48 +0200
Subject: [PATCH v2] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
In-Reply-To: <20240624015314.2249128-1-make24@iscas.ac.cn>
References: <20240624015314.2249128-1-make24@iscas.ac.cn>
Message-ID: <38b7ccb7-633a-4e51-9641-80ced078c33f@web.de>
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


Would you like to add any tags (like ?Fixes? and ?Cc?) accordingly?

Regards,
Markus
