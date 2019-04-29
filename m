From: Joel Stanley <joel@jms.id.au>
Date: Mon, 29 Apr 2019 07:53:53 +0000
Subject: [PATCH 1/2] ARM: dts: aspeed: Add aspeed-p2a-ctrl node
In-Reply-To: <20190425194853.140617-1-venture@google.com>
References: <20190425194853.140617-1-venture@google.com>
Message-ID: <CACPK8XchRsfJkB_p07g6LOyakaq8XH9yM3ve9annfNTTkGY4rg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2019 at 19:48, Patrick Venture <venture@google.com> wrote:
>
> Add a node for the aspeed-p2a-ctrl module.  This node, when enabled will
> disable the PCI-to-AHB bridge and then allow control of this bridge via
> ioctls, and access via mmap.
>
> Signed-off-by: Patrick Venture <venture@google.com>

Applied to the aspeed SoC tree.

Cheers,

Joel
