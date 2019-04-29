From: Olof Johansson <olof@lixom.net>
Date: Mon, 29 Apr 2019 10:05:40 -0700
Subject: [PATCH 1/2] ARM: dts: aspeed: Add aspeed-p2a-ctrl node
In-Reply-To: <20190425194853.140617-1-venture@google.com>
References: <20190425194853.140617-1-venture@google.com>
Message-ID: <20190429170540.27bc3fu6nvab2vc5@localhost>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 25, 2019 at 12:48:53PM -0700, Patrick Venture wrote:
> Add a node for the aspeed-p2a-ctrl module.  This node, when enabled will
> disable the PCI-to-AHB bridge and then allow control of this bridge via
> ioctls, and access via mmap.
> 
> Signed-off-by: Patrick Venture <venture@google.com>

Patrick,

Please send these to Joel and Andrew (and cc the mailing lists). No need to
send patches that there are active maintainers for to arm at kernel.org directly.

(As a matter of fact, drivers/soc/aspeed should go through them too, even if
I applied the first patch directly just now).


-Olof
